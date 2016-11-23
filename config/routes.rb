Rails.application.routes.draw do
  devise_for :users

  root :to => 'posts#index'

  get    'posts',                                                        :to => 'posts#index'
  post   'posts/new',                                                    :to => 'posts#create'
  get    'posts/with_feedback/:type',                                    :to => 'posts#with_feedback'
  get    'posts/:id',                                                    :to => 'posts#show'
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

  get    'search',                                                       :to => 'search#results'

  get    'apps',                                                         :to => 'api_keys#index'
  get    'apps/admin',                                                   :to => 'api_keys#admin_list'
  get    'apps/new',                                                     :to => 'api_keys#new'
  post   'apps/new',                                                     :to => 'api_keys#create'
  get    'apps/:id/edit',                                                :to => 'api_keys#edit'
  patch  'apps/:id/edit',                                                :to => 'api_keys#update'
  delete 'apps/:id',                                                     :to => 'api_keys#destroy'

  get    'analytics',                                                    :to => 'analytics#index'
  get    'analytics-api/views_by_period',                                :to => 'analytics#pageviews_over_time'
  get    'analytics-api/views_by_country',                               :to => 'analytics#pageviews_by_country'

  get    'authentication/initiate',                                      :to => 'se_auth#initiate'
  post   'authentication/redirect',                                      :to => 'se_auth#redirect'
  get    'authentication/target',                                        :to => 'se_auth#target'
  get    'authentication/complete',                                      :to => 'se_auth#already_done'

  get    'api/posts/by_url',                                             :to => 'api#posts_by_url'
end
