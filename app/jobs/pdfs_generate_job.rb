class PdfsGenerateJob < ApplicationJob
  queue_as :default

  def perform(html, save_path, post_id)
    Rails.logger.info "Inside PdfsGenerateJob perform method"
    pdf = WickedPdf.new.pdf_from_string(html)

    FileUtils.mkdir_p(File.dirname(save_path))  # Ensure the directory exists

    File.open(save_path, 'wb') do |file|
      file << pdf
    end

    Rails.logger.info "****************************************"
    Rails.logger.info "************** PDF GENERATED !!!!!!! *************"
    Rails.logger.info "****************************************"
    Rails.logger.info "Post ID: #{post_id}"
    Rails.logger.info "File saved at: #{save_path}"
    Rails.logger.info "****************************************"
  end
end
