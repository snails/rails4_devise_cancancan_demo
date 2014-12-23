class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @post = current_user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    redirect_to post_path(@post) if @comment.save
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
