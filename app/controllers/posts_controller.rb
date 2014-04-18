class PostsController < ApplicationController

  def index
    @posts = Post.all.group_by(&:date)
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      #do something
    else
      #do something
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      #do something
    else
      #do something
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    #redirect_to somewhere
  end

end
