require 'nokogiri'

class Fetcher
  KEY_WORDS = ['Foto', 'Bild']
  SEPARATORS = [':', '©', ' ']

  attr_reader :document

  def initialize(html_document)
    @document = Nokogiri::HTML(html_document)
  end

  def copyright
    text = fetch_by_img || fetch_by_tags || general_div_fetch
    regexp = Regexp.new("[#{KEY_WORDS.join('|')}][#{SEPARATORS.join('|')}] (.+)")

    text.match(regexp).captures.join.strip if text
  end

  private

  def fetch_by_tags
    tags = ['i', 'p']
    css_selector = KEY_WORDS.map do |kw|
      tags.map { |tag| (tag + ':contains("' + kw + '")') }
    end.join(', ')

    node = document.at_css(css_selector)
    node.text if !node.nil?
  end

  def fetch_by_img
    css_selector = KEY_WORDS.map {|kw| 'img[title*="' + kw + '"]' }.join(', ')

    node = document.at_css(css_selector)
    node.attr('title') if !node.nil?
  end

  def general_div_fetch
    css_selector = KEY_WORDS.map {|kw| 'div:contains("' + kw + '")'}.join(', ')

    node = document.at_css(css_selector)
    node.text if !node.nil?
  end
end
