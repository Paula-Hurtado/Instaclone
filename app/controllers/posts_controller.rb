class PostsController < ApplicationController
    def index
        @posts = Post.all 
    end
    def new
        @post = Post.new 
    end
    def create  
        @post = Post.new(post_params)
        @post.user_id = current_user.id
         if @post.save
            redirect_to @post 
            flash[:notice] = "post created!"
         else 
            redirect_back(fallback_location: root_path)
            flash[:alert] = "post creation failed"
         end 
    end
    def show 
        @post = Post.find(params[:id])
    end 

    private
    def post_params 
        params.require(:post).permit(:caption, :pic)
    end 
end
