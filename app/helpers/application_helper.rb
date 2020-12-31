module ApplicationHelper
  def cached_block(name,time,&block)
    ret = CACHE.get(name) unless CACHE.nil?
    if ret.nil?
      ret = block.call
      CACHE.set(name,ret,time) unless CACHE.nil?
    end
    ret
  end

  def reset_oddeven_class
    @alternate_odd_even_state = nil
  end

  def oddeven_class(str1 = "odd", str2 = "even")
     @alternate_odd_even_state = true if @alternate_odd_even_state.nil?
     @alternate_odd_even_state = !@alternate_odd_even_state
     @alternate_odd_even_state ? str2 : str1
  end

  def user_class(color)
    #TODO: Fix to not suck
    return nil
    h = CACHE.get "user_emblems" unless CACHE.nil?
    unless h
      h = Hash.new
      Emblem.all.each{|e| h[e.id]=e.css}
      CACHE.set "user_emblems",h,24.hours unless CACHE.nil?
    end
    h[color]
  end

  def user_link_with_avatar(user,color)
    out = String.new
    out << '<img class="sprite" src="'+user.sprite.public_filename+'" alt="sprite" /> ' if user.sprite && user.avatar_xhtml.blank?
    out << '<a class="member '+(h color)+'" href="/members/'+(user.permalink)+'">'+((user.avatar_xhtml unless user.avatar_xhtml.blank?) || (h user.name))+'</a>'
    out << '<p class="rank">'+user.rank+'</p>' unless user.rank.blank?
    out << '<p class="rank">TODO: check avatar html safety'
    out.html_safe
  end

  def user_link(user,specialpage=nil)
    return '' unless user.is_a?(User)
    color = user_class(user.emblem_id)
    color = String.new if color.nil?

    if specialpage == :edit
      %(<a class="member #{h(color)}" href="/members/#{h(user.permalink)}/edit">#{h(user.name)}</a>).html_safe
    elsif specialpage == :with_avatar
      if @forum && @forum.serious_business && !user.sb_avatar.blank?
        user.sb_avatar
      else
        user_link_with_avatar(user,color) unless (@logged_in_user.hide_avatars rescue false)
      end
    elsif specialpage == :ubercms
      %(<a class="member #{h(color)}" href="#{ubercms_user_path(user)}">#{h(user.name)}</a>).html_safe
    elsif specialpage == :ip_address
      %(<a class="member #{h(color)}" href="/forum/ip_address_user/#{h(user.permalink)}/edit">#{h(user.name)}</a>).html_safe
    else
      %(<a class="member #{h(color)}" href="/members/#{h(user.permalink)}">#{h(user.name)}</a>).html_safe
    end
  end

  def topic_link(topic)
    return '' unless topic.is_a?(Topic)
    out = String.new
    #forum = topic.forum.nickname
    #cat = topic.forum.category.nickname
    if @logged_in_user
      out += '<a class="firstarrow" href="'+topic.URL+'/first">
                <img src="/include/images/forum/topic-arrow-first.png" alt="Arrow icon" title="Skip to First Post" />
              </a>'
    end
    "#{out}<a class=\"topic #{user_class(topic.emblem_id)}\" href=\"#{topic.url}\">#{h topic.name}</a>".html_safe
  end

  def changeable_time(time_or_approximate_string,ago_string=" ago",exact_string=nil,default="No Time Given",from_now_string=" from now")
    if time_or_approximate_string.is_a?(Time) && exact_string.nil? && ago_string.is_a?(String)
      if time_or_approximate_string > Time.now
        approximate_string = time_ago_in_words(time_or_approximate_string)+from_now_string
      else
        approximate_string = time_ago_in_words(time_or_approximate_string)+ago_string
      end
      if @logged_in_user.is_a?(User) && @logged_in_user.timezone.is_a?(String) && tz = ActiveSupport::TimeZone[@logged_in_user.timezone]
        timezoned = time_or_approximate_string.in_time_zone tz
        thenow = Time.now.in_time_zone tz
        yesterday = 1.day.ago.in_time_zone tz
        if timezoned.strftime("%A, %B %d %Y") == thenow.strftime("%A, %B %d %Y")
          exact_string = "Today, "+timezoned.strftime("%H:%M")
        elsif timezoned.strftime("%A, %B %d %Y") == yesterday.strftime("%A, %B %d %Y")
          exact_string = "Yesterday, "+timezoned.strftime("%H:%M")
        else
          exact_string = timezoned.strftime("%B #{timezoned.day.ordinalize}, %Y %H:%M")
        end
      else
        exact_string = time_or_approximate_string.to_formatted_s(:long_ordinal)
      end
    elsif !time_or_approximate_string.is_a?(String) || !ago_string.is_a?(String) || !exact_string.is_a?(String)
      return default
    end

    if @logged_in_user.is_a?(User) && @logged_in_user.preferences.is_a?(Hash) && @logged_in_user.preferences[:changeable_time] == :exact
      out = '<span class="changeabletime" title="'+approximate_string+'">'+exact_string+'</span>'
    else
      out = '<span class="changeabletime" title="'+exact_string+'">'+approximate_string+'</span>'
    end
    out.html_safe
  end

  def postMatoCode(input,forum=nil)
    #stub
    input
  end

  def sprite(sprite,sizeoffset=10.0,options={})
    if sprite.is_a?(Sprite)
      %(<img class="sprite" style="width:#{sprite.width/sizeoffset}em; height:#{sprite.height/sizeoffset}em; #{options[:left] ? "left:#{options[:left]};" : ""} #{options[:top] ? "top:#{options[:top]};" : ""}" src="#{sprite.public_filename}" />).html_safe
    else
      ""
    end
  end

  def will_paginate(*args)
    nil
  end
end
