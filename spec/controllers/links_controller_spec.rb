# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'GET redirect' do
    let(:short_link_instance) { ShortLinkService.new('http://www.betterspecs.org').call }
    let(:short_link) { short_link_instance.link_hash }
    let(:invalid_hash) { 'some_invalid_value' }

    context 'when link is valid' do
      it 'redirects to right link' do
        get :redirect, params: { link_hash: short_link }
        expect(response.status).to eq(302)
        response.should redirect_to short_link_instance.original_link
      end
    end
    context 'when link is invalid' do
      it 'redirects to application main page' do
        get :redirect, params: { link_hash: invalid_hash }
        expect(response.status).to eq(302)
        response.should redirect_to "http://#{ENV['client_root']}/404"
      end
    end
  end
end
