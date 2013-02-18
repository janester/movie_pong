MoviePong::Application.routes.draw do
  root :to => 'home#index'
  get '/play/start' => 'play#start'
  post '/play/actor_check' => 'play#actor_check'
  get 'play/update_player_score' => 'play#update_player_score', :as => 'update_p'
  get 'play/update_computer_score' => 'play#update_computer_score', :as => 'update_c'
  get 'play/find_movie' => 'play#find_movie'
  get 'play/' => 'play#play'
  get 'score/' => 'score#_score'
end
