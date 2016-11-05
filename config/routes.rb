Rails.application.routes.draw do
  devise_for :users

  root :to => 'posts#index'

  get    'posts',                                                        :to => 'posts#index'
  get    'posts/:id',                                                    :to => 'posts#show'
  post   'posts/new',                                                    :to => 'posts#create'
  get    'posts/:id/edit',                                               :to => 'posts#edit'
  patch  'posts/:id/edit',                                               :to => 'posts#update'
  delete 'posts/:id',                                                    :to => 'posts#destroy'
  get    'posts/:id/feedback',                                           :to => 'feedbacks#post'

  get    'reasons',                                                      :to => 'reasons#index'
  get    'reasons/:id',                                                  :to => 'reasons#show'
  get    'reasons/:id/edit',                                             :to => 'reasons#edit'
  patch  'reasons/:id/edit',                                             :to => 'reasons#update'
  delete 'reasons/:id',                                                  :to => 'reasons#destroy'

  get    'users',                                                        :to => 'users#index'
  post   'users/:id/promote',                                            :to => 'users#promote'
  post   'users/:id/demote',                                             :to => 'users#demote'

  get    'bots',                                                         :to => 'authorized_bots#index'
  get    'bots/new',                                                     :to => 'authorized_bots#new'
  post   'bots/new',                                                     :to => 'authorized_bots#create'
  delete 'bots/:id',                                                     :to => 'authorized_bots#destroy'

  post   'feedbacks/new',                                                :to => 'feedbacks#create'
end
