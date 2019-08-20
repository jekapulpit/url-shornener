class EventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'Events'

  def perform(link_hash)
    link = Link.find_by(link_hash: link_hash)
    Ahoy::GeocodeJob.perform_now(link.visits.last.visit) if link.visits.last
    puts 'added location successfully'
  end
end