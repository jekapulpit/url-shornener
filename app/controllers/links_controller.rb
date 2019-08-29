# frozen_string_literal: true

class LinksController < ApplicationController
  skip_before_action :track_ahoy_visit, only: %i[count_rows index]

  def index
    render json: Link.joins('left join ahoy_visits on links.link_hash = ahoy_visits.link_hash')
                     .select('links.*, count(ahoy_visits.ip) as visits_number, count(DISTINCT ahoy_visits.ip) as unique_visits_number')
                     .group(:original_link, :link_hash, :created_at, :updated_at)
                     .order('visits_number desc')
                     .limit(params[:stopIndex].to_i - params[:startIndex].to_i)
                     .offset(params[:startIndex]), each_serializer: LinkSerializer
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
