class LinksController < ApplicationController
  def create
    link = ShortLinkService.new(params[:original_link]).call
    render json: {
        link: "#{ENV['api_root']}/#{link.link_hash}",
        errors: link.errors
    }
  end

  def redirect
    link = Link.find(params[:link_hash])
    ahoy.track "class", title: 'Some awesome information'
    redirect_to link.original_link
  end
end
