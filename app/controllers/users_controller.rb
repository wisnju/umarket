class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "注册成功！欢迎加入UMARKET！"
      redirect_to @user
      # 处理注册成功的情况
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    #微博分页显示
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
