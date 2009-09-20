# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openclipartbrowser_session',
  :secret      => 'f2634aa8b6d280bced701ad4507835d121d63cc2cbb049b6b88a186af5087c66d66868c53cb1fd955b9e26a7584f58155a5b879cdaa26e299f0b4092358c38ed'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
