# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# This file sets the ssl_cert_file environment variable such that
#   https requests will work
ENV["SSL_CERT_FILE"] = "C:\\Ruby22\\cacert.pem"
