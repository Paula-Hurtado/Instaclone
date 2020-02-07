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

    def destroy
        post = Post.find(params[:id])
        if current_user == post.user
            post.destroy
            redirect_to "/posts"
            flash[:notice] = "Post destroyed"
        else 
            redirect_back(fallback_location: root_path)
            flash[:alert] = "Not authorized to delete post"
        end 
    end
    def update
        post = Post.find(params[:id])
        if current_user == post.user
            post = Post.find(params[:id])
            post.update(post_params)
            redirect_to "/posts" 
            flash[:notice] = "Update successful!"
        else 
            redirect_back(fallback_location: root_path)
            flash[:alert] = "Not authorized to edit post"
        end 
    end

    def edit
        @post = Post.find(params[:id])
        if current_user != @post.user
            redirect_back(fallback_location: root_path)
            flash[:alert] = "Not authorized to edit post"
        end  
    end

    private
    def post_params 
        params.require(:post).permit(:caption, :pic)
    end 
    def update_params 
        params.require(:post).permit(:caption)
    end 
end
