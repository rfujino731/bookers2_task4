class UsersController < ApplicationController
  before_action :authenticate_user!
	before_action :baria_user, only: [:update,:edit]

  def show
    @book = Book.new
    @myuser = User.find(current_user.id)
    @linkuser = User.find(params[:id])
    if @myuser == @linkuser
       @user = User.find(current_user.id)
       @books = Book.where(user_id:@user)
    else
       @user = User.find(params[:id])
       @books = Book.where(user_id:@user)
    end
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end
  
  def edit
      @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       # @book = Book.new
  		 redirect_to(user_path(current_user.id), notice: "successfully updated user!")
    else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

end
