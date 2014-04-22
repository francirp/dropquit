class PostsController < ApplicationController
  :set_post_type

  def new
    @post = post_class.new(date: Date.today)
  end

  def index
    @posts = post_class.all.order("created_at DESC").group_by(&:date)
    @post = post_class.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to send("#{post_type.underscore.pluralize}_path"), notice: "Successfully added."
    else
      #do something
    end
  end

  def update
    @post = post_class.find(params[:id])

    if @post.update_attributes(params[:post])
      #do something
    else
      #do something
    end
  end

  def destroy
    @post = post_class.find(params[:id])
    @post.destroy
    #redirect_to somewhere
  end


  private

    def set_post_type
      @post_type = post_type
    end

    def post_type
      @post_type = params[:type] || 'Post'
    end

    def post_class
      post_type.constantize
    end

    def post_params
      params.require(post_type.underscore.to_sym).permit(:type, :content, :date, :stayed_clean)
    end
end
