require 'spec_helper'

describe Fetcher do
  context 'when copyright is in html tag' do
    it 'fetches copyright for photo' do
      sample_page = File.read(File.join("spec", "data", "test_page.html"))

      expect(Fetcher.new(sample_page).copyright).to eq('Marco Einfeldt')
    end
  end

  context 'when copyright is in img tag' do
    it 'fetches copyright for photo' do
      sample_page = File.read(File.join("spec", "data", "test_page2.html"))

      expect(Fetcher.new(sample_page).copyright).to eq('Sebastian von Melle')
    end
  end
end
