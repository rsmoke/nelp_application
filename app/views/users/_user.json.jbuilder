json.extract! user, :id, :google_id, :name, :email_address, :avatar_url, :locale, :hosted_domain, :created_at, :updated_at
json.url user_url(user, format: :json)
