require 'spec_helper'

describe Fetcher do
  use_vcr_cassette

  let(:sample_page) { open(url) }

  context 'when copyright is in html tag' do
    context 'i or p tag' do
      let(:url) { 'http://www.stuttgarter-nachrichten.de/inhalt.chor-aus-pretoria-zu-gast-in-stuttgart-suedafrikanische-klaenge-im-theaterhaus.200bba58-e54d-4c2a-91de-ab06b9b592f8.html' }

      it 'fetches copyright for photo' do
        expect(Fetcher.new(sample_page).copyright).to eq('Lichtgut/Max Kovalenko')
      end
    end

    context 'div tag' do
      let(:url) { 'http://www.augsburger-allgemeine.de/augsburg-land/Chormusik-mit-tschechischem-Akzent-id38019737.html' }

      it 'fetches copyright for photo' do
        expect(Fetcher.new(sample_page).copyright).to eq('Sigrid Wagner')
      end
    end
  end

  context 'when copyright is in img tag' do
    let(:url) { 'http://www.kleinezeitung.at/k/kaernten/lavanttal/peak_lavanttal/5011256/Lavanttaler-Wochenvorschau_Ein-ChormusikErlebnis-mit-jungen-Stimmen' }

    it 'fetches copyright for photo' do
      expect(Fetcher.new(sample_page).copyright).to eq('KK/Veranstalter')
    end
  end

  context 'when copyright is only ©' do
    let(:url) { 'http://magazin.klassik.com/news/teaser.cfm?ID=12745' }

    it 'fetches copyright for photo' do
      expect(Fetcher.new(sample_page).copyright).to eq('Robert Lehmann')
    end
  end
end
