# frozen_string_literal: true

class LinksController < ApplicationController
  def create
    link = ShortLinkService.new(params[:original_link]).call
    ahoy.track('create', title: 'link creation event', link_hash: link.link_hash)
    render json: {
      link: "#{ENV['api_root']}/#{link.link_hash}",
      errors: link.errors
    }
  end

  def redirect
    link = Link.find(params[:link_hash])
    ahoy.track('visit', title: 'redirection event', link_hash: link.link_hash)
    redirect_to link.original_link
  end

  def index
    render json: {
        links: Link.all.map(&:with_visit_stats)
    }
  end
end
