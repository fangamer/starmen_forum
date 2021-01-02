module RedCloth::Formatters::HTML
  # change the boring regular html from the gem to the forum's method
  def bbquote(opts)
    quote = "<blockquote>"
    matched = opts[:cite].match(/(\d+)\;(.*)/) if opts[:cite].is_a?(String)
    if matched
      m = Message.find(matched[1]);
      quote += "<div class=\"citey\"><cite title=\"Posted on #{m.created_at.strftime("%B %d %Y %I:%M%p")}\"><a href=\"#{m.URL}\">#{matched[2]}</a></cite></div>"
    else
      quote += "<div class=\"citey\"><cite>#{opts[:cite]}</cite></div>" if opts[:cite]
    end
    quote += "<div class=\"quotey\">#{opts[:text]}</div></blockquote>\n"
  rescue ActiveRecord::RecordNotFound
    quote += "<div class=\"quotey\">#{opts[:text]}</div></blockquote>\n"
  end
end
