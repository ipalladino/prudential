class ListingsController < ApplicationController
  include SessionHelper
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:create, :edit, :update, :destroy, :new]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing_attachments = @listing.listing_attachments.all
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing_attachment = @listing.listing_attachments.build
  end

  # GET /listings/1/edit
  def edit
  end

  # GET /listings/1/edit_attachments
  def edit_attachments
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        params[:listing_attachments]['listing_attachment'].each do |l|
           @listing_attachment = @listing.listing_attachments.create!(:listing_image => l, :listing_id => @listing.id)
        end
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        params[:listing_attachments]['listing_attachment'].each do |l|
           @listing_attachment = @listing.listing_attachments.create!(:listing_image => l, :listing_id => @listing.id)
        end
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def check_if_admin
      if(is_admin?)
        return true
      else
        flash[:notice] = 'You need to be signed in to perform that action'
        redirect_to :back
      end
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :description, listing_attachments_attributes: [:id, :listing_id, :listing_image])
    end
end
