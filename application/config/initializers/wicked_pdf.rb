WickedPdf.configure do |config|
  config.exe_path = File.join(`rvm gemdir`.strip, 'bin', 'wkhtmltopdf')
end
