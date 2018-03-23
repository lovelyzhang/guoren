Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'login#init'

  get '/login', to: 'login#init'
  post '/login', to: 'login#login'
  get 'logout', to: 'login#logout'

  get '/signup', to: 'users#new'
  get '/profile', to: 'users#edit'
  get '/forgetpasswd', to: 'users#forgetpasswd'
  get '/changepasswd', to: 'users#changepasswd'
  post '/changepasswd', to: 'users#changepasswd'
  post '/changeprofile', to: 'users#changeprofile'

  get '/main', to: 'main#show'
  get '/activity', to: 'main#activity'

  get '/chat', to: 'chat#index'
  post '/newmsg', to: 'chat#new'
  get '/notify', to: 'chat#notify'
  get '/query', to: 'chat#query'
  get '/online', to: 'chat#online'

  get '/microposts', to: 'micro_posts#show'
  post '/newpost', to: 'micro_posts#new'
  get '/deletepost', to: 'micro_posts#delete'


  get '/comments', to: 'comments#get'
  post '/newcomment', to: 'comments#new'

  resource :users
  resource :micro_posts

end
