class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "推荐已发布!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #删除微博
  def destroy
    @micropost.destroy
    flash[:success] = "推荐已删除"
    redirect_to request.referrer || root_url
  end
  
  private
    #只能通过web编辑微博内容
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
