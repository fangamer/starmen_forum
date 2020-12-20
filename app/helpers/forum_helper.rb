module ForumHelper
  def lock_link(topic)
    link_to (topic.locked ? "Unlock" : "Lock"),:action=>:lock,:id=>topic.id
  end

  def unseen(time1,time2)
    return " unseen" unless time1.is_a?(Time) && time2.is_a?(Time)
    return "" if time1 > time2
    " unseen"
  end

  def uploaded_files(session)
    out = String.new
    out << '
                <ul id="attachments">'
    if session
      i = 0
      for id in session
        begin
          attachment = ForumAttachment.find(id)
          if attachment.image?
            out << '
                  <li class="'+(i%2 == 0 ? 'odd' : 'even')+'">
                    <a class="filename" href="'+attachment.public_filename+'" target="_new">
                      <span class="thumb"><img src="'+attachment.public_filename(:small)+'" /></span>
                      <span class="filename">'+(h attachment.filename)+'</span>
                    </a>
                    <a class="add" href=""><span><img src="/include/images/button-add.png" alt="X Icon" title="Add Image to Post" />Add to Post</span></a>
                  </li>'
          else
            out << '
                  <li class="'+(i%2 == 0 ? 'odd' : 'even')+'">
                    <a href="'+attachment.public_filename+'" target="_new">
                      <span class="filename">'+(h attachment.filename)+'</span>
                      <span class="thumb"></span>
                    </a>
                  </li>'
          end
          i+=1
        rescue ActiveRecord::RecordNotFound
        end
      end
    end
    out << '
              </ul>'
    out
  end

  def attachments(forumAttachments,size)
    out = String.new
    unless forumAttachments.empty? || size == "none"
      out << '
            <div class="attachments">
              <h4>Attachments:</h4>
              <ul>'
      for attachment in forumAttachments
        if attachment.image? && size != "text"
          attachment2 = ForumAttachment.find(:first,:conditions=>{:parent_id=>attachment.id,:thumbnail=>size})
          out << '
                <li class="attachedimage">
                  <a style="width: '+attachment2.width.to_s+'px !important; height: '+attachment2.height.to_s+'px;" href="'+attachment.public_filename+'">
                    <img border="0" style="width: '+attachment2.width.to_s+'px !important; height: '+attachment2.height.to_s+'px;" src="'+attachment2.public_filename+'" />
                  </a>
                </li>' if attachment2
        else
          out << '
                <li class="attachedfile">
                  <a href="'+attachment.public_filename+'">
                    '+(h attachment.filename)+'
                  </a>
                </li>'
        end
      end
      out << '
              </ul>
            </div>'
    end
    out
  end

  def display_moderators(forum)
    return "" unless forum.is_a?(Forum)
    output = "<ul>"
    users = Permission.where(permission:"Moderator",individual_id:forum.id).preload({:user=>:permissions}).map(&:user).reject{|user| user.has_permission("Administrator") || user.has_permission("Moderator_All")}.uniq
    users.each {|user| output << "<li>#{user_link(user)}</li>"} # user_linke is also html_safe
    output << "<li>Supermoderators</li><li>Administrators</li></ul>"
    output.html_safe
  end

  def display_tabs(forum_id)
    output = String.new
    tabs = ForumTab.where(forum_id:forum_id).preload(:sprite)
    for tab in tabs
      output << %(<li id="tab#{tab.id}"><a href="#{h(tab.link)}">)
      if tab.sprite.blank?
        output << %(<img class="sprite" style="width: 1.6em; height: 2.4em; top: -.4em; left: .7em;" src="/include/images/sprites/sprite974.gif" alt="Starman sprite" title="#{h(tab.name)}" />)
      else
        output << %(<img class="sprite" style="top:#{tab.top||0}em; left:#{tab.left||0}em;" src="#{h(tab.sprite.public_filename)}" alt="#{h(tab.sprite.title)}" title="#{h(tab.name)}" />)
      end
      output << %(<span>#{h tab.name}</span></a></li>)
    end
    output.html_safe
  end

  def display_report(infraction)
    return "THE REPORT WAS EMPTY!" if infraction.nil?
    out = '<h2><a href="'+infraction.message.URL+'">View Offending Post</a></h2>'
    out << "<p>A message by #{user_link(infraction.message.creator)} in #{topic_link(infraction.message.topic)} on #{changeable_time(infraction.message.created_at)} posted:</p>"
    out << "<blockquote><div class='quotey'><p>&ldquo;#{infraction.message.preview(100000)}&rdquo;</p></div></blockquote>"

    if report = infraction.message.report
      out << "<p>The message was reported by #{user_link(report.user)} on #{changeable_time(report.created_at)} with a report of:</p>"
      out << "<blockquote><div class='quotey'><p>&ldquo;#{report.body}&rdquo;</p></div></blockquote>"
    end

    if infraction.resolved_at
      out << "<p>The infraction was resolved by #{user_link(infraction.resolver)} on #{changeable_time(infraction.resolved_at)} with a reason of:<p>"
      out << "<blockquote><div class='quotey'><p>&ldquo;#{infraction.reason}&rdquo;</p></div></blockquote>"
      if infraction.resolution.is_a?(String) && infraction.resolution.length > 0
        out << "<p>#{user_link(infraction.resolver)} noted a moderator-only resolution of:</p>"
        out << "<blockquote><div class='quotey'><p>&ldquo;#{infraction.resolution}&rdquo;</p></div></blockquote>"
      end
    end

    if infraction.infraction_group
      out << "<p>#{user_link(infraction.user)} was awarded #{infraction.infraction_group.points} points for this post.</p>"
    end

    if infraction.deleted_message || infraction.locked_topic || infraction.moved_topic_to || infraction.ban_from_topic_until
      out << "<ul>"
      out << "<li>The message was deleted.</li>" if infraction.deleted_message
      out << "<li>The topic was locked.</li>" if infraction.locked_topic
      out << "<li>The topic was moved.</li>" if infraction.moved_topic_to
      out << "<li>#{user_link(infraction.user)} was banned from the topic until #{changeable_time(infraction.ban_from_topic_until)}.</li>" if infraction.ban_from_topic_until
      out << "</ul>"
    end

    out
  end

  def topic_page_links(topic)
    return "" unless topic.is_a?(Topic)
    return "" if topic.replies < 50
    total_pages = ((topic.replies)/50)+1
    output = ' <span class="page_links">('
    output << " &hellip;" if total_pages > 5
    ([total_pages-4,1].max..total_pages).each do |page|
      output << " <a href=\"#{topic.URL}/page/#{page}\">#{page}</a>"
    end
    output << " )</span>"
  end

  def render_forum_sprite(forum)
    '<img class="sprite" style="width: 3.2em; height: 3.2em;" src="'+(forum.sprite ? forum.sprite.public_filename : "/include/images/sprites/icon-forum-blanko.png")+'" alt="'+(h forum.name)+' sprite" title="'+(forum.name)+'" />'
  end
end
