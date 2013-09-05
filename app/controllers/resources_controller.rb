class ResourcesController < ApplicationController
	def show
		clpath = params[:classification_path]
		crpath = params[:craft_path]
		rpath  = params[:resource_path]

		@classification = Classification.where(path: clpath).first
		@craft = @classification.crafts.where(path: crpath).first
		@resource = @craft.resources.where(path: rpath).first
		upvotes = @resource.upvotes
		
		if @resource.user
			@contributor = @resource.user
		end
		
		@commentable = Comment.new
		@upvotable = Upvote.new

		if signed_in?
			@recommended = Upvote.where(user_id: current_user.id, upvotable_id: @resource.id, upvotable_type: "Resource")
		else
			@recommended = []
		end
	end

	def new
		@resource = Resource.new
		@crafts = Craft.all
	end

	def create
		@resource = Resource.create(params[:resource])
		@resource.path = @resource.name.downcase.gsub(" ", "-")
		
		@resource.user_id = current_user.id
		@resource.upvotes_count = 1
		
		if Rails.env.development? && !@resource.avatar_file_name
			kit = IMGKit.new(@resource.link)
			img = kit.to_img(:png)
			file  = Tempfile.new(["template_#{@resource.id}", 'png'], 'tmp',
                         :encoding => 'ascii-8bit')
			file.write(img)
			file.flush
			@resource.avatar = open(file)
		end

		if @resource.save
			upvote = Upvote.new
			upvote.user_id = current_user.id
			upvote.upvotable_id = @resource.id
			upvote.upvotable_type = "Resource"
			upvote.save

		else
			render '/resources/new'
		end

	end

	def update
		
	end

	def edit
		@resource = Resource.find_by_id(params[:id])
	end

end
