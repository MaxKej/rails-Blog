# Kontroler CommentsController obsługuje operacje związane z komentarzami.
class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :update]
  before_action :authenticate_admin!, only: [:destroy, :update]

  # Lista wszystkich komentarzy na stronie z paginacją.
  #
  # @return [void]
  def list
    @comments = Comment.page(params[:page]).per(10)
  end

  # Wyświetla formularz do tworzenia nowego komentarza.
  #
  # @return [void]
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
  end

  # Inicjalizuje nowy komentarz do posta.
  #
  # @return [void]
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  # Tworzy nowy komentarz dla posta.
  #
  # @return [void]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id if user_signed_in?

    if @comment.save
      redirect_to @post, notice: 'Komentarz został pomyślnie utworzony.'
    else
      redirect_to @post, alert: 'Nie udało się utworzyć komentarza.'
    end
  end

  # Edytuje istniejący komentarz.
  #
  # @return [void]
  def edit
  end

  # Aktualizuje istniejący komentarz.
  #
  # @return [void]
  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: 'Komentarz został pomyślnie zaktualizowany.'
    else
      render @comment.post
    end
  end

  # Usuwa istniejący komentarz.
  #
  # @return [void]
  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: 'Komentarz został pomyślnie usunięty.'
  end

  private

  # Silne parametry dla komentarza.
  #
  # @return [ActionController::Parameters] dozwolone parametry
  def comment_params
    params.require(:comment).permit(:content)
  end

  # Ustawia komentarz na podstawie ID z parametrów.
  #
  # @return [void]
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Uwierzytelnia, czy aktualny użytkownik jest administratorem.
  #
  # @return [void]
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to @comment.post, alert: 'Nie masz uprawnień do wykonania tej akcji.'
    end
  end
end