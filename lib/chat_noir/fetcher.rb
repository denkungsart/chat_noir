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

  private

  def fetch_by_tags
    node = document.at_css('p:contains("Foto:")')
    node.text if !node.nil?
  end

  def fetch_by_img
    node = document.at_css('img[title*="Foto:"]')
    node.attr('title') if !node.nil?
  end
end
