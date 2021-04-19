Rails.application.routes.draw do
  get '/events/list'
  post '/webhooks/create'
  get '/payments/create'
  get '/payments/create/customer/:customer_id', to: 'payments#create'
  post '/payment/create/customer/:customer_id', to: 'payments#create_payment'
  get '/payments/customer/:customer_id', to: 'payments#list'
  get '/payments/list', to: 'payments#list'
  get '/customers', to: 'customers#index'
  get '/customers/create', to: 'customers#create'
  get '/customer/:customer_id', to: 'customer_details#view'
  post '/customer/create_customer', to: 'customers#create_customer'
  get '/customers/create_user_success', to: 'customers#create_user_success'
end
