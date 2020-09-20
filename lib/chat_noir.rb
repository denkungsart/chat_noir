require "open-uri"
require "chat_noir/version"
require "chat_noir/basic_search"
require "chat_noir/fetcher"

module ChatNoir
  OPTIONS = { "Accept-Encoding" => "plain" }

  def self.copyright(url)
    begin
      Fetcher.new(URI.open(url, OPTIONS)).copyright
    rescue => e
      puts "Error: #{e.message}"
      nil
    end
  end
end
