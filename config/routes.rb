Rails.application.routes.draw do

  # Public Marketing Pages
 root "marketing#nashville"
 get "/about" => "marketing#about", as: "about"
 get "/get-involved" => "marketing#get_involved", as: "get_involved"
 get "/nashville" => "marketing#nashville", as: "nashville"

end
