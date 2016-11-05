Rails.application.routes.draw do
  devise_for :users

  root :to => 'posts#index'

  get    'posts',                                                        :to => 'posts#index'
  get    'posts/:id',                                                    :to => 'posts#show'
  post   'posts/new',                                                    :to => 'posts#create'
  get    'posts/:id/edit',                                               :to => 'posts#edit'
  patch  'posts/:id/edit',                                               :to => 'posts#update'
  delete 'posts/:id',                                                    :to => 'posts#destroy'

  get    'reasons',                                                      :to => 'reasons#index'
  get    'reasons/:id',                                                  :to => 'reasons#show'
  get    'reasons/:id/edit',                                             :to => 'reasons#edit'
  patch  'reasons/:id/edit',                                             :to => 'reasons#update'
  delete 'reasons/:id',                                                  :to => 'reasons#destroy'

  get    'users',                                                        :to => 'users#index'
  post   'users/:id/promote',                                            :to => 'users#promote'
  post   'users/:id/demote',                                             :to => 'users#demote'
end
