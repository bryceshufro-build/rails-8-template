Rails.application.routes.draw do
  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })

  # READ
  get("/messages", { :controller => "messages", :action => "index" })

  get("/messages/:path_id", { :controller => "messages", :action => "show" })

  # UPDATE

  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })

  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the Application resource:

  # CREATE
  post("/insert_application", { :controller => "applications", :action => "create" })

  # READ
  get("/applications", { :controller => "applications", :action => "index" })

  get("/applications/:path_id", { :controller => "applications", :action => "show" })

  # UPDATE

  post("/modify_application/:path_id", { :controller => "applications", :action => "update" })

  # DELETE
  get("/delete_application/:path_id", { :controller => "applications", :action => "destroy" })

  #------------------------------

  # Routes for the Listing resource:

  # CREATE
  post("/insert_listing", { :controller => "listings", :action => "create" })

  # READ
  get("/listings", { :controller => "listings", :action => "index" })

  get("/listings/:path_id", { :controller => "listings", :action => "show" })

  # UPDATE

  post("/modify_listing/:path_id", { :controller => "listings", :action => "update" })

  # DELETE
  get("/delete_listing/:path_id", { :controller => "listings", :action => "destroy" })

  #------------------------------

  devise_for :users

  get("/", { :controller => "pages", :action => "home" })
end
