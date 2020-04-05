Rails.application.routes.draw do

  resources :updates

  resources :states do
    resources :counties
  end
  resources :counties

  # Public Marketing Pages
 root to: redirect("/counties/davidson")
 get '/nashville', to: redirect("/counties/davidson")

 get "/about" => "marketing#about", as: "about"
 get "/get-involved" => "marketing#get_involved", as: "get_involved"

end
