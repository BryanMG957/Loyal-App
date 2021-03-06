Rails.application.routes.draw do
  resources :payments
  resources :service_types
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  get "/pull_calendars" => "calendars#pull_calendars"
  get "/calendars/pull_calendars" => "calendars#pull_calendars"
  post "/pull_calendars" => "calendars#pull_calendars"
  post "/calendars/pull_calendars" => "calendars#pull_calendars"
  get "/calendarmain" => "homes#calendarmain"
  get "/bills/unbilled" => "bills#unbilled"
  get "/bills/:id/remove_appt/:appt_id" => "bills#remove_appt"
  get "/appointments/newappt_calendar_window/:new_date" => "appointments#newappt_calendar_window"
  get "/appointments/:id/editappt_calendar_window" => "appointments#editappt_calendar_window"
  get "/clients/:id/ledger" => "clients#ledger"
  get "/" + Rails.configuration.x.host + "/sign_out" => "auth0#destroy"
  get "/sign_out" => "auth0#destroy"
  get "/unauthorized" => "homes#unauthorized"
  root 'homes#index'

  resources :appointments
  resources :bills
  resources :calendars
  resources :employees
  resources :clients
  resources :companies
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
