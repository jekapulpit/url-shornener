Rails.application.routes.draw do
  post '/links/', to: 'links#create'
end
