Bundler.require :web
Bundler.require :development if development?
require_relative 'tinder'

also_reload 'tinder.rb'

get '/style.css' do
  less :style
end

get '/' do
  # Tinder.sign_in
  Tinder.refresh_subscribed_users
  # p Tinder.fetch_updates
  @matches = Tinder.sort_by_matched
  @online = Tinder.sort_by_recently_online
  haml :index
end

not_found do
  haml :'404'
end