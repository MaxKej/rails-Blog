WickedPdf.configure do |config|
  config.layout = 'pdf.html'
  config.exe_path = File.join(`rvm gemdir`.strip, 'bin', 'wkhtmltopdf')
end
