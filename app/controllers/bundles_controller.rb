class BundlesController < ApplicationController
  def new
    @bundle = Bundle.new
    if current_user
      @resources = []
      current_user.upvotes.each do |upvote|
        @resources << upvote.upvotable
      end
    end
  end

  def create
    @bundle = Bundle.new(params[:bundle])
    @bundle.user_id = current_user.id
    @bundle.path = @bundle.name.downcase.gsub(" ", "-")
    @bundle.save

    temp_array = params[:resources].split('|').compact.uniq
    resources_array = []
    temp_array.each do |number|
      if resources_array.size < 6
        resources_array << number
      end
    end
    resources_array.each do |id_resource|
      inclusion = Inclusion.new
      inclusion.bundle_id = @bundle.id
      inclusion.resource_id = id_resource
      inclusion.save
    end

    redirect_to bundle_url(@bundle.path)
  end

  def index

  end

  def show
    @bundle = Bundle.find_by_path(params[:bundle_path])
    @resources = @bundle.resources
    @commentable = Comment.new
    @upvotable = Upvote.new
  end

  def edit

  end

  def update

  end

  def destroy

  end
end