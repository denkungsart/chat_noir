require "open-uri"
require "chat_noir/version"
require "chat_noir/fetcher"

module ChatNoir
  def self.copyright(url)
    begin
      Fetcher.new(open(url)).copyright
    rescue => e
      puts "Error: #{e.message}"
      nil
    end
  end
end
