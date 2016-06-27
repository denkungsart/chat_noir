require 'nokogiri'

class Fetcher
  attr_reader :document

  def initialize(html_document)
    @document = Nokogiri::HTML(html_document)
  end

  def copyright
    text = fetch_by_tags || fetch_by_img
    text.match(/Foto: (.+)/).captures.join if text
  end

  def fetch_by_tags
    document.at_css('p:contains("Foto:")')&.text
  end

  def fetch_by_img
    document.at_css('img[title*="Foto:"]')&.attr('title')
  end
end
