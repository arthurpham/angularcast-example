require 'feedzirra'

class RailscastFeed
  def self.sync
    # add additional elements to be parsed from the feed entries
    Feedzirra::Feed.add_common_feed_entry_element(:enclosure, :value => :url, :as => :video_url)
    Feedzirra::Feed.add_common_feed_entry_element('itunes:duration', :as => :duration)

    # private rss http://railscasts.com/subscriptions/SHCgyzZHehc3L9XpYajM0g/episodes.rss
    # public rss http://feeds.feedburner.com/railscasts
    feed = Feedzirra::Feed.fetch_and_parse("http://railscasts.com/subscriptions/SHCgyzZHehc3L9XpYajM0g/episodes.rss")
    feed.entries.each do |entry|
      Episode.create_from(entry, 'railscasts')
    end
  end
end
