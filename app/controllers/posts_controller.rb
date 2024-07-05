class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :download_pdf, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:edit, :update, :destroy, :download_pdf]

  def list
    @posts = Post.page(params[:page]).per(10)
  end

  def index
    @posts = Post.page(params[:page]).per(10)
    render json: {
      posts: @posts,
      current_page: @posts.current_page,
      total_pages: @posts.total_pages,
      total_count: @posts.total_count
    }
  end

  def show
    @comments = @post.comments.page(params[:page]).per(10)
    # render json: { post: @post, comments: @comments }
  end

  # def download_pdf
  #   @post = Post.find(params[:id])
  #   @comments = @post.comments
  #
  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #       # Generate PDF content using Prawn
  #       pdf = generate_pdf(@post, @comments)
  #
  #       # Send the generated PDF as a downloadable attachment
  #       send_data pdf.render, filename: "post.pdf", type: "application/pdf", disposition: "attachment"
  #     end
  #   end
  # end

  #require 'nokogiri'

  # def download_pdf
  #   Rails.logger.info "****************************************"
  #   Rails.logger.info "Entering download_pdf method"
  #   @post = Post.find(params[:id])
  #   @comments = @post.comments
  #
  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #       Rails.logger.info "PDF format block entered"
  #
  #       # Create an empty HTML document using Nokogiri
  #       doc = Nokogiri::HTML::DocumentFragment.parse('')
  #
  #       # Add UTF-8 meta tag and link to a Google Font supporting Polish characters
  #       head_content = <<-HTML
  #         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  #         <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  #         <style>
  #           body { font-family: 'Roboto', sans-serif; }
  #         </style>
  #       HTML
  #
  #       doc << head_content
  #
  #       # Append your HTML content to the document
  #       doc << "<h1>Title: #{@post.title}</h1>"
  #       doc << "<p>Content: #{@post.content}</p>"
  #       doc << "<p>#{@post.created_at} </p>"
  #
  #       # Append comments if any
  #       if @comments.any?
  #         doc << "<div class='comments'>"
  #         @comments.each do |comment|
  #           doc << "<div class='comment'>"
  #           if comment.user
  #             doc << "<p>User: #{comment.user.email}</p>"
  #           else
  #             doc << "<p>User: Gość</p>"
  #           end
  #           doc << "<p>Content: #{comment.content}</p>"
  #           doc << "<p>Updated At: #{comment.updated_at&.strftime('%d %b %Y %H:%M:%S')}</p>"
  #           doc << "</div>"
  #         end
  #         doc << "</div>"
  #       else
  #         doc << "<p>No comments.</p>"
  #       end
  #
  #       # Convert the Nokogiri document to HTML string
  #       html = doc.to_html
  #
  #       # Generate file name
  #       file_name = "#{@post.title}-#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf"
  #
  #       # Set save path
  #       save_path = Rails.root.join("public/export", file_name)
  #
  #       Rails.logger.info "Generated HTML, about to perform PdfsGenerateJob"
  #       PdfsGenerateJob.perform_now(html, save_path.to_s, @post.id)  # Use perform_now for immediate processing
  #
  #       Rails.logger.info "PDF generated, sending file"
  #       send_file save_path, type: 'application/pdf', disposition: 'attachment', filename: file_name
  #     end
  #   end
  # end

  # def download_pdf
  #   Rails.logger.info "****************************************"
  #   Rails.logger.info "Entering download_pdf method"
  #   @post = Post.find(params[:id])
  #   @comments = @post.comments
  #
  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #       Rails.logger.info "PDF format block entered"
  #
  #       # Render the ERB template to a string with the PDF layout
  #       html = render_to_string(template: 'app/views/posts/show.pdf.erb', formats: [:html], locals: { post: @post, comments: @comments }, layout: 'app/views/layouts/pdf.html')
  #
  #       # Generate file name
  #       file_name = "#{@post.title}-#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf"
  #
  #       # Set save path
  #       save_path = Rails.root.join("public/export", file_name)
  #
  #       Rails.logger.info "Generated HTML, about to perform PdfsGenerateJob"
  #       PdfsGenerateJob.perform_now(html, save_path.to_s, @post.id)  # Use perform_now for immediate processing
  #
  #       Rails.logger.info "PDF generated, sending file"
  #       send_file save_path, type: 'application/pdf', disposition: 'attachment', filename: file_name
  #     end
  #   end
  # end


  def download_pdf
    Rails.logger.info "****************************************"
    Rails.logger.info "Entering download_pdf method"
    @post = Post.find(params[:id])
    @comments = @post.comments

    respond_to do |format|
      format.pdf do
        Rails.logger.info "PDF format block entered"

        # Generate the PDF content as a string
        pdf_content = render_to_string(
          pdf: "#{@post.title}-#{Time.now.strftime('%Y%m%d%H%M%S')}",
          template: 'posts/show',
          layout: 'pdf',
          locals: { post: @post, comments: @comments },
          lang: "pl",
          encoding: 'UTF-8'
        )

        # Generate file name
        file_name = "#{@post.title}-#{Time.now.strftime('%Y%m%d%H%M%S')}.pdf"

        # Set save path
        save_path = Rails.root.join("public/export", file_name)

        # Save the PDF to the specified path
        File.open(save_path, 'wb') do |file|
          file << pdf_content
        end

        Rails.logger.info "PDF generated and saved, sending file"

        # Send the file as a response
        send_file save_path, type: 'application/pdf', disposition: 'attachment', filename: file_name
      end
    end
  end



  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to @comment.post, alert: 'You are not authorized to perform this action.'
    end
  end
  # def generate_pdf(post, comments)
  #   # Preprocess post content
  #   preprocessed_post_content = replace_polish_characters(post.content)
  #
  #   Prawn::Document.new do |pdf|
  #     pdf.text "Post: #{post.title}"
  #     pdf.text "Content: #{preprocessed_post_content}" # Use preprocessed content
  #
  #     if comments.any?
  #       pdf.move_down 10
  #       pdf.text "Comments:"
  #       comments.each do |comment|
  #         # Preprocess comment content
  #         preprocessed_comment_content = replace_polish_characters(comment.content)
  #
  #         pdf.text "User: #{comment.user.email if comment.user}"
  #         pdf.text "Content: #{preprocessed_comment_content}" # Use preprocessed content
  #         pdf.text "Updated At: #{comment.updated_at&.strftime('%d %b %Y %H:%M:%S')}"
  #         pdf.move_down 10
  #       end
  #     else
  #       pdf.text "No comments."
  #     end
  #   end
  # end


  # def replace_polish_characters(text)
  #   polish_chars_mapping = {
  #     'ą' => 'a',
  #     'ć' => 'c',
  #     'ę' => 'e',
  #     'ł' => 'l',
  #     'ń' => 'n',
  #     'ó' => 'o',
  #     'ś' => 's',
  #     'ź' => 'z',
  #     'ż' => 'z'
  #     # Add more mappings as needed
  #   }
  #
  #   text.tr(polish_chars_mapping.keys.join, polish_chars_mapping.values.join)
  # end

end