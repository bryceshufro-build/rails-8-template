Rails.application.routes.draw do
  post("/insert_message", { :controller => "messages", :action => "create" })

  get("/messages", { :controller => "messages", :action => "index" })

  get("/messages/:path_id", { :controller => "messages", :action => "show" })

  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })

  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  post("/insert_application", { :controller => "applications", :action => "create" })

  get("/applications", { :controller => "applications", :action => "index" })

  get("/applications/:path_id", { :controller => "applications", :action => "show" })

  post("/modify_application/:path_id", { :controller => "applications", :action => "update" })

  get("/delete_application/:path_id", { :controller => "applications", :action => "destroy" })

  get("/listings/new", { :controller => "listings", :action => "new_form" })
  get("/listings", { :controller => "listings", :action => "index" })

  post("/insert_listing", { :controller => "listings", :action => "create" })
  post("/modify_listing/:path_id", { :controller => "listings", :action => "update" })

  get("/delete_listing/:path_id", { :controller => "listings", :action => "destroy" })
  get("/delete_listing_photo/:photo_id", { :controller => "listings", :action => "destroy_photo" })

  get("/listings/:path_id", { :controller => "listings", :action => "show" })

  get("/profile", { :controller => "profiles", :action => "show" })
  get("/profile/edit", { :controller => "profiles", :action => "edit_form" })
  post("/modify_profile", { :controller => "profiles", :action => "update" })
  get("/delete_profile", { :controller => "profiles", :action => "destroy" })

  devise_for :users

  get("/", { :controller => "pages", :action => "home" })
end
