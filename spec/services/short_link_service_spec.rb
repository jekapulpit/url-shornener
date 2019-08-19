require 'rails_helper'

RSpec.describe ShortLinkService do
   let(:test_link) { 'http://www.betterspecs.org' }
   context 'when link does not exists in history' do
      it 'creates new one' do
          expect(Link.all.count).to eq 0
          ShortLinkService.new(test_link).call
          expect(Link.all.count).to eq 1
      end
   end
   context 'when link does exists in history' do
     before do
       ShortLinkService.new(test_link).call
     end
     it 'creates new one' do
       expect(Link.all.count).to eq 1
       ShortLinkService.new(test_link).call
       expect(Link.all.count).to eq 1
     end
   end
end
