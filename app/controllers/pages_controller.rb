class PagesController < ApplicationController
	def home
		@resources = Resource.home_list
		@crafts = Craft.top6
		@users = User.top6

        if current_user
            followed = []
            current_user.relationships.each do |r|
                followed << User.find(r.followed_id)
            end
            @recent_resources = []
            followed.each do |user|
                @recent_resources << user.resources.last
            end
        end

	end

  def search
    @q = params[:q]
   
    @search_r = Resource.search() { keywords(params[:q]) }
    @search_c = Craft.search() { keywords(params[:q]) }
    @search_u = User.search() { keywords(params[:q]) }

    @check_r = []
    @check_c = []
    @check_u = []
 
    @search_r.each_hit_with_result { |hit, resource| @check_r << resource }
    @search_c.each_hit_with_result { |hit, craft| @check_c << craft }
    @search_u.each_hit_with_result { |hit, user| @check_u << user }
  end
end 