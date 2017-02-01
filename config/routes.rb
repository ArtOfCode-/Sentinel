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
  get    'posts/aid/:id',                                                :to => 'posts#by_answer_id'
  get    'posts/:id/feedback',                                           :to => 'feedbacks#post'
  get    'posts/:answer_id/flag_options',                                :to => 'posts#flag_options'
  post   'posts/:answer_id/flag',                                        :to => 'posts#cast_flag'

  get    'reasons',                                                      :to => 'reasons#index'
  get    'reasons/:id',                                                  :to => 'reasons#show'
  get    'reasons/:id/edit',                                             :to => 'reasons#edit'
  patch  'reasons/:id/edit',                                             :to => 'reasons#update'
  delete 'reasons/:id',                                                  :to => 'reasons#destroy'

  get    'users',                                                        :to => 'users#index'
  post   'users/:id/promote',                                            :to => 'users#promote'
  post   'users/:id/demote',                                             :to => 'users#demote'
  get    'users/:id',                                                    :to => 'users#show'
  post   'users/:user_id/deauth',                                        :to => 'se_auth#deauth'

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

  get    'authentication/initiate',                                      :to => 'se_auth#initiate'
  post   'authentication/redirect',                                      :to => 'se_auth#redirect'
  get    'authentication/target',                                        :to => 'se_auth#target'
  get    'authentication/complete',                                      :to => 'se_auth#already_done'

  get    'graphs/posts_by_hour',                                         :to => 'graphs#posts_by_hour'
  get    'graphs/reason_feedback_types/:id',                             :to => 'graphs#reason_feedback_types'

  get    'api/posts/by_url',                                             :to => 'api#posts_by_url'
  get    'api/reasons/:ids',                                             :to => 'api#reasons_by_id'
  get    'api/blacklist_stats',                                          :to => 'api#blacklist_stats'

  get    'review',                                                       :to => 'review#index'
  post   'review/:post_id',                                              :to => 'review#add_feedback'
end
