class LoginController < ApplicationController

  def input_form
    @new_user = false
  end

  def login
    # 入力された値を受け取る
    user_name = params[:user_name]
    user_pass = params[:user_pass]
    # 該当するユーザをDBから検索
    login_user = User.where(name: user_name).where(pass: user_pass)
    # 入力されたユーザがいるかどうかを判定
    if defined?(login_user.first.id) != nil
      session[:user_id] = login_user.first.id
      redirect_to('/')
    else
      # 間違えたメッセージ・新規登録への誘導
      flash[:notice] = "ユーザ名かパスワードが間違っています。
                        新規登録の場合は新規登録ボタンを押してください。"
      redirect_to('/input_form')
    end
  end

  def sign_up
    # 入力された値を受け取る
    user_name = params[:user_name]
    user_pass = params[:user_pass]
    user_table = User.new(
      name: user_name,
      pass: user_pass
    )
    user_table.save
    redirect_to('/')
  end

end
