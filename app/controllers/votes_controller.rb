class VotesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  after_filter :update_timestamp, :except => [:index, :show, :list]
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  #http://pathfindersoftware.com/2008/07/drying-up-rails-controllers-polymorphic-and-super-controllers/
  def create
    @klass = params[:voteable_type]
    if @klass.to_s.downcase == 'comment'
      @comment = Comment.find(params[:comment_id])
      @vote = @comment.votes.create(params[:vote])
      current_user.votes.push(@vote)
      redirect_to post_path(@comment.post_id)
    else
      @post = Post.find(params[:post_id])
      @vote = @post.votes.create(params[:vote])
      current_user.votes.push(@vote)
      redirect_to post_path(@post)
    end
  end

  def list
    @klass = params[:voteable_type]
    if @klass.to_s.downcase == 'comment'
      @comment = Comment.find(params[:id])
      @votes = @comment.votes
    else
      @post = Post.find(params[:id])
      @votes = @post.votes
    end
  end
  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end

  private
  def update_timestamp
    @klass = params[:voteable_type]
    if @klass.to_s.downcase == 'comment'
      @comment = Comment.find(params[:comment_id])
      @comment.update_attribute(:update_at, Time.now)
    else
      @post = Post.find(params[:post_id])
      @post.update_attribute(:updated_at, Time.now)
    end
  end
end
