# frozen_string_literal: true

class LinksController < ApplicationController
  skip_before_action :track_ahoy_visit, only: %i[count_rows index]

  def index
    render json: Link.with_visit_stats
                     .paginate(params[:startIndex].to_i, params[:stopIndex].to_i), each_serializer: LinkSerializer
  end

  def show
    render json: Link.find(params[:link_hash]), serializer: LinkShowSerializer
  end

  def create
    link = ShortLinkService.new(params[:original_link]).call
    current_visit.update_attributes(:link_hash => link.link_hash)
    render json: {
      link: "#{ENV['api_root']}/#{link.link_hash}",
      errors: link.errors
    }
  end

  def count_rows
    render json: Link.all.count
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
