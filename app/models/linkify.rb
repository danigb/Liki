class Linkify
  MENTIONS = /(?:^|\s)(?:#)[^\s^:^.^,^<^"^(^)]+/

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
      lstrip
  end

  def to_param(hashtag)
    hashtag[1..-1].
      gsub(/(\d+)/, '-\1-').
      underscore.
      parameterize.
      gsub(/_/, '-')
  end
end
