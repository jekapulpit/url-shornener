# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortLinkService do
  let(:test_link) { 'http://www.betterspecs.org' }
  context 'when link does not exist in history' do
    it 'creates new one' do
      expect(Link.all.count).to eq 0
      ShortLinkService.new(test_link).call
      expect(Link.all.count).to eq 1
    end
  end
  context 'when link exists in history' do
    before do
      ShortLinkService.new(test_link).call
    end
    it 'does not create new one' do
      expect(Link.all.count).to eq 1
      ShortLinkService.new(test_link).call
      expect(Link.all.count).to eq 1
    end
  end
end
