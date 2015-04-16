Rails.application.routes.draw do

  get 'incomes/index'

  get 'incomes/new'

  get 'salaries/index'

  get 'salaries/new'

  get 'expenses/index'

  get 'expenses/new'

  get 'payments/new'

  get 'payments/index'

  get 'customers/new'

  get 'customers/index'

  get 'new/index'

  get 'invoices/new'

  get 'invoices/index'

  get 'items/index'

  get 'items/new'

  get 'students/upload'

  get 'students/payment'

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :students do
    collection { post :import }
    collection do
      post "pay"
      get "validate_model"
      get "validate_rollnum"
    end
  end

  resources :grades do
    member do
      get "addFeeToClass"
    end
    collection do
      get "validateClassTitle"
    end
  end

  resources :items do
    collection do
      get 'validateItemCode'
      post 'adding'
      get 'addStock'
      get 'export'
    end
  end

  resources :invoices do
    member do
      get 'credit'
      get 'cancel'
      get 'customer'
    end
    collection do
      get 'canceled'
      post 'updateInvoice'
      get 'getCredit'
    end
  end

  resources :sales do
    member do
      get 'credit'
      get 'cancel'
      get 'customer'
    end
    collection do
      get 'canceled'
      post 'updateInvoice'
      
    end
  end
  
  resources :bills do
    collection do
      post 'createBill'
      get 'getbills'
      get 'removebills'
      get 'validateCode'
    end
  end

  resources :customers
  resources :payments
  resources :expenses
  resources :employees do
    member do
      get 'loan'
      
    end
    collection do
      post 'payLoan'
    end
  end
  resources :salaries
  resources :incomes

  resources :lines do
    collection do
      post 'createBill'
      get 'getbills'
      get 'removebills'
      get 'validateCode'
    end
  end


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
