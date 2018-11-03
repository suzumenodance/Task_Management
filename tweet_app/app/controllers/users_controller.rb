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
    @users = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "icon1.png",
      password: params[:password]
    )
    if @users.save
      session[:user_id] = @users.id
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

    if params[:image]
      @users.image_name = "#{@users.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@users.image_name}", image.read)
    end

    if @users.save
      flash[:notice] = "ユーザーの編集に成功しました"
      redirect_to("/users/index")
    else
      # redirect_to("/userss/#{@users.id}/edit")
      render("users/edit")#このアクションの＠変数を使える、直でHTMLを表示
    end
  end

  def login_form

  end

  def login
    @users = User.find_by(email: params[:email],
                          password: params[:password])
    if @users
      session[:user_id] = @users.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
