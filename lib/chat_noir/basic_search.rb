class BasicSearch
  KEY_WORDS = [
    'Foto', 'Foto:', 'Foto ©',
    'Bild:',
    'Quelle:',
    '©'
  ]

  attr_reader :document

  def initialize(document)
    @document = document
  end

  def search_for_copyright
    %i(fetch_by_img fetch_by_tags general_div_fetch).each do |method|
      if text = send(method)
        matched_text = match_copyright(text)
        return matched_text if matched_text
      end
    end
    nil
  end

  private

  def match_copyright(text)
    regexp = Regexp.new("(#{KEY_WORDS.join('|')}) (.+)")

    if match = text.match(regexp)
      match.captures.last.strip
    end
  end

  def fetch_by_tags
    tags = ['i', 'p', 'span']
    css_selector = KEY_WORDS.map do |kw|
      tags.map { |tag| (tag + ':contains("' + kw + '")') }
    end.join(', ')

    node = document.at_css(css_selector)
    node.text if !node.nil?
  end

  def fetch_by_img
    css_selector = KEY_WORDS.map do |kw|
      'img[title*="' + kw + '"], img[alt*="' + kw + '"]'
    end.join(', ')

    node = document.at_css(css_selector)
    node.attr('title') || node.attr('alt') if !node.nil?
  end

  def general_div_fetch
    css_selector = KEY_WORDS.map {|kw| 'div:contains("' + kw + '")'}.join(', ')

    node = document.at_css(css_selector)
    node.text if !node.nil?
  end
end
