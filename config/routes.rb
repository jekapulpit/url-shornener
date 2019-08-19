# frozen_string_literal: true

Rails.application.routes.draw do
  post '/links/', to: 'links#create'
  get '/:link_hash', to: 'links#redirect'
end
