# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# required for https requests in ruby to work right
ENV["SSL_CERT_FILE"] = "C:\\Ruby22\\cacert.pem"
