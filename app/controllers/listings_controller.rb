class ListingsController < ApplicationController
  def index
    matching_listings = Listing.all

    @list_of_listings = matching_listings.order({ :created_at => :desc })

    render({ :template => "listing_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_listings = Listing.where({ :id => the_id })

    @the_listing = matching_listings.at(0)

    render({ :template => "listing_templates/show" })
  end

  def create
    the_listing = Listing.new
    the_listing.owner_id = params.fetch("query_owner_id")
    the_listing.title = params.fetch("query_title")
    the_listing.address = params.fetch("query_address")
    the_listing.neighborhood = params.fetch("query_neighborhood")
    the_listing.bedrooms = params.fetch("query_bedrooms")
    the_listing.bathrooms = params.fetch("query_bathrooms")
    the_listing.monthly_rent = params.fetch("query_monthly_rent")
    the_listing.available_on = params.fetch("query_available_on")
    the_listing.lease_end_on = params.fetch("query_lease_end_on")
    the_listing.description = params.fetch("query_description")
    the_listing.status = params.fetch("query_status")

    if the_listing.valid?
      the_listing.save
      redirect_to("/listings", { :notice => "Listing created successfully." })
    else
      redirect_to("/listings", { :alert => the_listing.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_listing = Listing.where({ :id => the_id }).at(0)

    the_listing.owner_id = params.fetch("query_owner_id")
    the_listing.title = params.fetch("query_title")
    the_listing.address = params.fetch("query_address")
    the_listing.neighborhood = params.fetch("query_neighborhood")
    the_listing.bedrooms = params.fetch("query_bedrooms")
    the_listing.bathrooms = params.fetch("query_bathrooms")
    the_listing.monthly_rent = params.fetch("query_monthly_rent")
    the_listing.available_on = params.fetch("query_available_on")
    the_listing.lease_end_on = params.fetch("query_lease_end_on")
    the_listing.description = params.fetch("query_description")
    the_listing.status = params.fetch("query_status")

    if the_listing.valid?
      the_listing.save
      redirect_to("/listings/#{the_listing.id}", { :notice => "Listing updated successfully." } )
    else
      redirect_to("/listings/#{the_listing.id}", { :alert => the_listing.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_listing = Listing.where({ :id => the_id }).at(0)

    the_listing.destroy

    redirect_to("/listings", { :notice => "Listing deleted successfully." } )
  end
end
