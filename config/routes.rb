Rails.application.routes.draw do
  # Routes for the Message resource:

  post("/insert_message", { :controller => "messages", :action => "create" })

  get("/messages", { :controller => "messages", :action => "index" })

  get("/messages/:path_id", { :controller => "messages", :action => "show" })


  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })

  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #application
  post("/insert_application", { :controller => "applications", :action => "create" })

  get("/applications", { :controller => "applications", :action => "index" })

  get("/applications/:path_id", { :controller => "applications", :action => "show" })


  post("/modify_application/:path_id", { :controller => "applications", :action => "update" })

  get("/delete_application/:path_id", { :controller => "applications", :action => "destroy" })

  post("/insert_listing", { :controller => "listings", :action => "create" })

  get("/listings", { :controller => "listings", :action => "index" })

  get("/listings/:path_id", { :controller => "listings", :action => "show" })

  post("/modify_listing/:path_id", { :controller => "listings", :action => "update" })

  get("/delete_listing/:path_id", { :controller => "listings", :action => "destroy" })


  devise_for :users

  get("/", { :controller => "pages", :action => "home" })
end
