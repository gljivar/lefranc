Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'D8wLMDzLkxVmwzAEZyMalQ', 'hGb9ftZjvIkKyWKFhf3westFYfC7sncnJnjMy8UxfjQ'
  provider :facebook, '431829256892441', '4cf34fd43e4f00efa00fe8eed2c14a52'
  provider :google_oauth2, '685175429521.apps.googleusercontent.com', 'Gkz-EIo1KRbWPBqloQB8RY0m',
    { :approval_prompt => "auto" }
  provider :windowslive, '00000000480EC427', 'Kd9W0cX5QjiN2cOBNzrfMbKWDVxz0QD7', :scope => 'wl.basic'
end
