Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '387160252305-l1o87gokdk74njk2j9l5g0q6ta2627em.apps.googleusercontent.com', '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',
    {
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50
    }
end

OmniAuth.config.allowed_request_methods = %i[get]
