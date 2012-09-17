class PostsController < ApplicationController

  before_filter :require_user, :except => [:show, :index]
  before_filter :is_own_post?
  before_filter :require_own_post, :only => [:edit, :destroy, :update]

  def require_own_post
    @post = Post.find(params[:id])
    unless   is_own_post?
      redirect_to posts_path
    end
  end

  def is_own_post?
    @is_own_post = @current_user && ((@post && @current_user.id == @post.user_id) || @current_user.is_admin)
  end
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all.sort_by{|p| - p.updated_at.to_i}
    @posts = Post.search(params[:type], params[:search])
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
