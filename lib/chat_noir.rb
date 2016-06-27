require "open-uri"
require "chat_noir/version"
require "chat_noir/fetcher"

module ChatNoir
  def self.copyright(url)
    Fetcher.new(open(url)).copyright
  end
end
