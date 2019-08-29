# frozen_string_literal: true

class LinksController < ApplicationController
  def index
    render json: Link.includes(:visits), each_serializer: LinkSerializer
  end

  def create
    link = ShortLinkService.new(params[:original_link]).call
    current_visit.update_attributes(:link_hash => link.link_hash)
    render json: {
      link: "#{ENV['api_root']}/#{link.link_hash}",
      errors: link.errors
    }
  end

  def redirect
    link = Link.find_by(link_hash: params[:link_hash])
    if link
      current_visit.update_attributes(:link_hash => link.link_hash)
      EventWorker.perform_async(params[:link_hash])
      redirect_to link.original_link
    else
      redirect_to "http://#{ENV['client_root']}/404"
    end
  end
end
