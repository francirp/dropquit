class PostsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_object_type

  def new
    @post = object_class.new
    @page_title = @post.form_label
  end

  def show
    @post = Post.find(params[:id])
    @page_title = "Post Detail"
  end

  def index
    @paginated_posts = object_class.all.order("created_at DESC").page(params[:page])
    @posts = Post.group_by_date(@paginated_posts)
    @page_title = "Latest Member #{object_class.new.type_text.pluralize}"
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

  # def update
  #   @post = object_class.find(params[:id])

  #   if @post.update_attributes(params[:post])
  #     #do something
  #   else
  #     #do something
  #   end
  # end

  # def destroy
  #   @post = object_class.find(params[:id])
  #   @post.destroy
  #   #redirect_to somewhere
  # end


  private

    def set_object_type
      @object_type = object_type
    end

    def object_type
      @object_type = params[:type] || controller_name.classify
    end

    def object_class
      object_type.constantize
    end

    def post_params
      params.require(object_type.underscore.to_sym).permit(:type, :content, :stayed_clean)
    end
end
