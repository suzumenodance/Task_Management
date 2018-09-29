class UsersController < ApplicationController
  def index

    @users = User.all
    # @users = User.new(name:"first_user", email:"first_user@co.jp")
    # @users.save
  end

  def show
    @users = User.find_by(id: params[:id])
  end

  def signup
    @users = User.new(name: params[:name], email: params[:email])
  end

  def create
    @users = User.new(name: params[:name], email: params[:email])
    if @users.save
      flash[:notice] = "登録に成功しました"
      redirect_to("/users/index")
    else
      # redirect_to("/userss/#{@users.id}/edit")
      render("users/signup")
    end
  end

  def edit
    @users = User.find_by(id: params[:id])

  end

  def update
    @users = User.find_by(id: params[:id])#URLの:idを取得
    @users.name = params[:name]#edit.html.erbのエディタの内容を取得
    @users.email = params[:email]
    # render("userss/edit")
    if @users.save
      flash[:notice] = "ユーザーの編集に成功しました"
      redirect_to("/users/index")
    else
      # redirect_to("/userss/#{@users.id}/edit")
      render("users/edit")#このアクションの＠変数を使える、直でHTMLを表示
    end
  end

end
