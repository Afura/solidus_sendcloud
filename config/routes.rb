Spree::Core::Engine.routes.draw do
  post '/webhooks/:integration_name' => 'sendcloud_webhooks#receive'

  # namespace :api, defaults: { format: 'json' } do
  #   resources :mollie do
  #     member do
  #       get :payment_methods
  #     end
  #   end
  # end

end