class BlogController < ApplicationController
  before_action :authenticate_user!, only: [:add_blog, :create_blog, :user_blog, :destroy, :edit_blog, :update]
  before_action :find_blog, only: [:show, :destroy, :edit_blog, :update]

  def add_blog
  end

  def show_all
    @blogs = Blog.all
  end

  def show
    @comments = Comment.where(blog_id: @blog.id)
    @comment = Comment.new
  end

  def user_blog
    user = current_user.id
    @blogs = Blog.where(user_id: user)
    @user = User.find_by(id: user)
  end

  def create_blog
    @blog = current_user.blogs.new(blog_add_params)

    if @blog.title.blank? || @blog.description.blank?
      @err = 'Title and description are required fields'
      render :add_blog
    elsif @blog.save
      redirect_to root_path
    else
      @err = 'File must be an image (JPEG/PNG/JPG) or not empty'
      render :add_blog
    end
  end 

  def destroy
    if current_user && current_user.id == @blog.user_id
      @blog.destroy
      redirect_to user_blog_path
    else
      redirect_to root_path
    end
  end

  def edit_blog
    redirect_to edit_blog_path unless @blog && current_user && current_user.id == @blog.user_id
  end

  def update
    if @blog && current_user && current_user.id == @blog.user_id
      if @blog.update(blog_params)
        redirect_to blog_path(@blog.id)
      else
        @err = 'File must be an image (JPEG/PNG/JPG )'
        render :edit_blog
      end
    else
      redirect_to root_path
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :description, :image)
  end

  def blog_add_params
    params.permit(:title, :description, :image)
  end

  def find_blog
    @blog = Blog.find_by(id: params[:id])
  end
end
