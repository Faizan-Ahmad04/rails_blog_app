class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    
    # def create
    #   @blog = Blog.find(params[:blog_id])
    #   @comment = @blog.comments.build(comment_params)
    #   @comment.user_id = current_user.id
    #   @comment.user_name = current_user.name
    #   if @comment.save
    #     redirect_to @blog
    #   else
    #     redirect_to root_path
    #   end
    # end

  def create
    @blog = Blog.find(params[:blog_id])
    @parent_comment = Comment.find_by(id: params[:parent_id]) if params[:parent_id].present?
    @comment = @blog.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.user_name = current_user.name
    @comment.parent = @parent_comment if @parent_comment

    if @comment.save
      redirect_to @blog
    else
      render 'blog/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to @blog
    else
      redirect_to root_path
    end
  end


  
  # def edit
  #   @comment = Comment.find(params[:id])
  #   redirect_to root_path unless @comment.editable_by?(current_user)
  # end

  # def update
  #   @comment = Comment.find(params[:id])
  #   redirect_to root_path unless @comment.editable_by?(current_user)

  #   if @comment.update(comment_params)
  #     redirect_to @comment.blog, notice: 'Comment successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  
    
    private
    
    def comment_params  
      params.require(:comment).permit(:content, :parent_id)
    end
  end
  