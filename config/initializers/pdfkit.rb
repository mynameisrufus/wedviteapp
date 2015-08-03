require 'pdfkit'

PDFKit.configure do |config|
  config.default_options = { page_size: 'A4', print_media_type: true }
  config.wkhtmltopdf = `which wkhtmltopdf`.strip if RUBY_PLATFORM =~ /darwin/
  config.verbose = false if Rails.env.production?
end
