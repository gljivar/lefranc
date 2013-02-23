Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, 'D8wLMDzLkxVmwzAEZyMalQ', 'hGb9ftZjvIkKyWKFhf3westFYfC7sncnJnjMy8UxfjQ'
	provider :facebook, '431829256892441', '4cf34fd43e4f00efa00fe8eed2c14a52'
end
