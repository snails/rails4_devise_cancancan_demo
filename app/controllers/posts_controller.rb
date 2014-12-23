class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index
    @posts = Post.paginate(page: params[:page])
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = current_user.posts.build
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
  def set_post
    @post = Post.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
end
