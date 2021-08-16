class PostImagesController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def search

  @results = @q.result
    # タグ検索
   # @tag_search = Product.tagged_with(params[:search])
  end



  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    #@post_image.save
    #redirect_to post_images_path
    if @post_image.save
      redirect_to post_images_path
    else
      render('post_images/new')
    end
  end


  def index
    @post_images = PostImage.page(params[:page]).reverse_order
    @users = User.all
    @user = current_user
      # キーワード検索
    @q = PostImage.ransack(params[:q])
    #@post_image = @search.result.order("created_at DESC").page(params[:page]).per(10)
    @post_image = @q.result.includes(:text).page(params[:page]).order("created_at desc")

    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @postimage = @hashtag.post_images.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    end

  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end


 private

  def set_q
    @q = PostImage.ransack(params[:q])
  end

  def post_image_params
    params.require(:post_image).permit(:image, :text, :hashbody, post_image_images_images: [], hashtag_ids: [])
  end

end
