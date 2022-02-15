Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  match 'library/api/v1/users' => 'users#newUser', :via => :post
  match 'library/api/v1/users' => 'users#getAll', :via => :get
  match 'library/api/v1/users/:id'=> 'users#getUser', :via => :get
  match 'library/api/v1/user/block/:id'=> 'users#blockUser',:via => :put   
  match 'library/api/v1/user/unblock/:id'=> 'users#unblockUser', :via => :put

  resources :books
  match 'library/api/v1/books' => 'books#getAllBook', :via => :get
  match 'library/api/v1/books/:id' => 'books#showBook', :via => :get
  match 'library/api/v1/books/:id' => 'books#update_book', :via => :put 
  match 'library/api/v1/book'=> 'books#newBook', :via => :post 

  resources :stocks
  match 'library/api/v1/stockmovement' => 'stocks#stockMovement', :via => :post
  match 'library/api/v1/movementhistory' => 'stocks#movementHistory', :via => :get

  resources :authentication
  match 'authentication/login' => 'authentication#login' , :via => :post

end
