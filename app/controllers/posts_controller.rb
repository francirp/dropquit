class PostsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_post_type

  def new
    @post = post_class.new(date: Date.today)
    @page_title = @post.form_label
  end

  def show
    @post = Post.find(params[:id])
    @page_title = "Post Detail"
  end

  def index
    @paginated_posts = post_class.all.order("created_at DESC").page(params[:page])
    @posts = Post.group_by_date(@paginated_posts)
    @post = post_class.new
    @page_title = "Latest Member #{@post.type_text.pluralize}"
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path, notice: "Successfully added."
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
      params.require(post_type.underscore.to_sym).permit(:type, :content, :stayed_clean)
    end
end
