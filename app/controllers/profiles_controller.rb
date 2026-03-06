class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @the_user = current_user
    @my_listings = Listing.where({ :owner_id => current_user.id }).order({ :created_at => :desc })
    @my_applications = Application.where({ :user_id => current_user.id }).order({ :created_at => :desc })

    render({ :template => "profile_templates/show" })
  end

  def edit_form
    @the_user = current_user

    render({ :template => "profile_templates/edit_form" })
  end

  def update
    the_user = current_user

    the_user.first_name = params.fetch("query_first_name")
    the_user.last_name = params.fetch("query_last_name")
    the_user.phone = params.fetch("query_phone")
    the_user.bio = params.fetch("query_bio")

    if the_user.valid?
      the_user.save
      redirect_to("/profile", { :notice => "Profile updated successfully." })
    else
      redirect_to("/profile/edit", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    current_user.destroy
    redirect_to("/", { :notice => "Profile deleted successfully." })
  end
end
