# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gray_whale_session',
  :secret      => 'e2535224aaff7f17adc261f6755959b0e51f2975d37d265f2f9a33499a46750fa61617ad774c3a5f6ce77d4a73566ac53a614ff49e24a2e6e74c004431f8fb60'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
