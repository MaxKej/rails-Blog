# Kontroler PagesController obsługuje różne statyczne strony i wyszukiwanie postów.
class PagesController < ApplicationController

  # Wyświetla stronę główną.
  #
  # @return [void]
  def home
  end

  # Wyszukuje posty na podstawie tytułu i wyświetla wyniki z paginacją.
  #
  # @return [void]
  # @example Przykład zapytania wyszukiwania
  #   GET /find?title=example
  def find
    # @posts = Post.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(10)
    if params[:title].present?
      query = {
        query: {
          match: {
            title: params[:title]
          }
        }
      }
    else
      query = {
        query: {
          match_all: {}
        }
      }
    end

    begin
      @posts = Post.search(query).page(params[:page]).per(10).records
    rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
      @posts = Post.none
    end
  end

  # Wyświetla stronę polityki prywatności.
  #
  # @return [void]
  def privacy
  end

  # Wyświetla statyczną stronę na podstawie identyfikatora.
  #
  # @return [void]
  # @example Przykład wywołania
  #   GET /pages/:id
  def show
    render params[:id]
  end
end