OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '193494760780-pgqtn6798hc49cf8790pm4bkr9u4cj33.apps.googleusercontent.com', 'MMvLFCx0FrAlrog6hrwmbqxY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '308592672822576', 'e0e07975253403c0ed9ab38b104d61f0', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end