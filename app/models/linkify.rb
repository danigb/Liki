module Linkify
  PREFIX = /(?:$|^|\s|\r|\n)*/
  HASHTAG = /(?:#)/
  HASHTAG_CUOTE = /(?:#")/
  NOSPACES = /[^\s^:^.^,^<"^(^)]+/
  NOQUOTE= /[^"]+"/
  MENTIONS = /#{PREFIX}#{HASHTAG_CUOTE}#{NOQUOTE}|#{PREFIX}#{HASHTAG}#{NOSPACES}/

  def links(text)
    return [] if text.blank?
    if block_given?
      text.gsub(MENTIONS) do |match|
        tag = match.lstrip
        " #{yield(tag, to_name(tag), to_param(tag))}"
      end
    else
      text.scan(MENTIONS).map(&:lstrip)
    end
  end

  def to_name(hashtag)
    hashtag[1..-1].
      gsub(/-/, ' ').
      gsub(/([A-Z])/, ' \1').
      gsub(/"\s/, '"').
      lstrip
  end

  def to_param(hashtag)
    hashtag[1..-1].
      gsub(/(\d+)/, '-\1-').
      underscore.
      parameterize.
      gsub(/_/, '-')
  end

  extend self
end
