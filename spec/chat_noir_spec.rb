require 'spec_helper'

describe ChatNoir do
  describe '.copyright' do
    let(:url) { 'http://www.rnz.de/nachrichten/metropolregion_artikel,-Deutsches-Chorfest-Kammerchor-Rhein-Neckar-wird-erster-in-Kategorie-Romantik-geistlich-_arid,199431.html#null' }

    it 'fetches page and search for copyright' do
      expect(ChatNoir.copyright(url)).to eq('Privat')
    end
  end
end
