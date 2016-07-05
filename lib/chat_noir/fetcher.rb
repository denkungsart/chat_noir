require 'nokogiri'

class Fetcher
  attr_reader :document

  def initialize(html_document)
    @document = Nokogiri::HTML(html_document).xpath('//body')
    raise "Body not found" if document.nil?
  end

  def copyright
    BasicSearch.new(document).search_for_copyright
  end
end
