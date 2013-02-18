require 'HTTParty'
require 'JSON'

class PlayController < ApplicationController
  def start
    choice = StartMovie.all.map(&:tmdb_id)
    a = choice.sample
    if SaidMovie.exists?(:tmdb_id => a)
      index = choice.index(a)
      choice.delete_at(index)
      a = choice.sample
    end
    @startmovie = StartMovie.where(:tmdb_id => a)
    @startmovie = @startmovie[0]
    @player = Score.sum(:player)
    @computer = Score.sum(:computer)
    if @player == 4
      redirect_to(play_lose_path) and return
    end
    if @computer == 4 and return
      redirect_to(play_win_path) and return
    end
  end

  def update_player_score
    Score.create(:player => 1)
    redirect_to(play_start_path)
  end

  def update_computer_score
    Score.create(:computer => 1)
    redirect_to(play_start_path)
  end

  def actor_check
    unless SaidMovie.exists?(:tmdb_id => params[:tmdb_id])
      SaidMovie.create(:title => params[:movie], :year => params[:year], :tmdb_id => params[:tmdb_id])
    end
    actor = params[:name].downcase
    if SaidActor.exists?(:name => actor)
      redirect_to(update_p_path) and return
    else
      Tmdb.api_key = "8ff73a8278a889d8d7d1994de5667869"
      Tmdb.default_language = "en"
      movie = params[:tmdb_id]
      movie = TmdbMovie.find(:id => movie)
      if movie.length == nil
        cast = movie.cast.select {|i| i.job == "Actor"}
      else
        cast = movie[0].cast.select {|i| i.job == "Actor"}
      end
      actor_array = []
      cast.each do |i|
        temp = {}
        temp[i.name.downcase] = i.id
        actor_array << temp
      end
      $actor = actor_array.detect {|i| i.keys.include?(actor)}
      if $actor != nil
        SaidActor.create(:name => $actor.keys[0])
        redirect_to(play_find_movie_path) and return
      else
        redirect_to(update_p_path) and return
      end
    end
  end

  def find_movie
    actor = HTTParty.get("http://api.themoviedb.org/2.1/Person.getInfo/en/json/8ff73a8278a889d8d7d1994de5667869/#{$actor.values[0]}")
    filmography = actor[0]["filmography"].select {|i| i["job"] == "Actor"}
    pop_films = {}
    filmography.each do |film|
      Tmdb.api_key = "8ff73a8278a889d8d7d1994de5667869"
      Tmdb.default_language = "en"
      begin
        movie = TmdbMovie.find(:id => film["id"])
      rescue
        retry
      end
      if movie.length == nil
        popularity = movie.popularity
      else
        popularity = movie[0].popularity
      end
      pop_films[popularity] = film
    end
    pop_films = Hash[pop_films.sort]
    pop_films = pop_films.to_a
    pop_films = pop_films[-3..-1].reverse
    pop_films.each do |i|
      if SaidMovie.exists?(:tmdb_id => i[1]["id"]) == false
        $movie = SaidMovie.create(:title => i[1]["name"], :year => i[1]["release"][0,4], :tmdb_id => i[1]["id"])
        redirect_to(play_path) and return
      end
    end
    redirect_to(update_c_path) and return
  end

  def play
    @player = Score.sum(:player)
    @computer = Score.sum(:computer)
    if @player == 4
      redirect_to(play_lose_path) and return
    end
    if @computer == 4 and return
      redirect_to(play_win_path) and return
    end
  end

  def win
    @final_actors = SaidActor.all
    @final_movies = SaidMovie.all
    @final_score_player = Score.sum(:player)
    @final_score_computer = Score.sum(:computer)
    SaidActor.delete_all
    SaidMovie.delete_all
    Score.delete_all
  end

  def lose
    @final_actors = SaidActor.all
    @final_movies = SaidMovie.all
    @final_score_player = Score.sum(:player)
    @final_score_computer = Score.sum(:computer)
    SaidActor.delete_all
    SaidMovie.delete_all
    Score.delete_all
  end

end
