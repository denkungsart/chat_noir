require 'spec_helper'

describe ChatNoir do
  use_vcr_cassette

  describe 'error handling' do
    before do
      allow(ChatNoir)
        .to receive(:open)
        .and_raise('Zlib::DataError: incorrect header check')
    end

    it 'returns nil if error is raise' do
      expect(ChatNoir.copyright('')).to eq(nil)
    end
  end

  describe '.copyright' do
    let(:url) { 'http://www.rnz.de/nachrichten/metropolregion_artikel,-Deutsches-Chorfest-Kammerchor-Rhein-Neckar-wird-erster-in-Kategorie-Romantik-geistlich-_arid,199431.html#null' }

    it 'fetches page and search for copyright' do
      expect(ChatNoir.copyright(url)).to eq('Privat')
    end

    context 'url with plain encoding' do
      let(:url) { 'http://www.sueddeutsche.de/politik/ukip-nach-dem-brexit-farage-drueckt-sich-vor-der-verantwortung-1.3062729' }

      it 'fetches page and search for copyright' do
        expect(ChatNoir.copyright(url)).to eq('Bloomberg')
      end
    end
  end
end
