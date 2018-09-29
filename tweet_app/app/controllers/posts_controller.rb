class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content])#new.html.erbのエディタの内容を取得
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to("/posts/index")
    else
      # redirect_to("/posts/#{@post.id}/edit")
      render("posts/new")#このアクションの＠変数を使える、直でHTMLを表示
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])#URLの:idを取得
    @post.content = params[:content]#edit.html.erbのエディタの内容を取得
    # render("posts/edit")
    if @post.save
      flash[:notice] = "投稿の編集に成功しました"
      redirect_to("/posts/index")
    else
      # redirect_to("/posts/#{@post.id}/edit")
      render("posts/edit")#このアクションの＠変数を使える、直でHTMLを表示
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])#URLの:idを取得
    @post.destroy
    flash[:notice] = "投稿#{params[:id]}を削除しました"
    redirect_to("/posts/index")
  end

end
