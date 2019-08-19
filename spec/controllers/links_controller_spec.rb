require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET redirect' do
    let(:short_link_instance) { ShortLinkService.new('http://www.betterspecs.org').call }
    let(:short_link) { short_link_instance.link_hash }
    it 'redirects to right link' do
      get :redirect, :params => { :link_hash => short_link }
      expect(response.status).to eq(302)
      response.should redirect_to short_link_instance.original_link
    end
  end
end
