class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def new
    @user = User.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
     redirect_to user_path(@user)
    else
     render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
  user = User.find(params[:id])
   unless user.id == current_user.id
    redirect_to user_path(current_user)
   end
  end
end
