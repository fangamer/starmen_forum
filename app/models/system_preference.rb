class SystemPreference < ApplicationRecord
  before_save :admins_only
  before_save :ensure_min_max_values
  before_save :clear_cache
  
  PREFERENCES = {
    "show_post_count_and_join_date_to_mod_admins"=>{:type=>:boolean,:pretty_name=>"Show post count and join date on the profile page only to mods and admins",:default=>false,:group=>"General"},
    "allow_silent_report"=>{:type=>:boolean,:pretty_name=>"Allow reports to be resolved silently",:default=>true,:group=>"General"},
    "show_forum_stats_to_mod_admins"=>{:type=>:boolean,:pretty_name=>"Show forum stats and 'who is logged in' to mods and admins only.",:default=>false,:group=>"General"},
    "max_character_limit_on_posts"=>{:type=>:integer,:pretty_name=>"Maximum number of characters per post. (Max: 65535)",:default=>25000,:group=>"General",:max=>65535,:min=>6},
    "min_character_limit_on_posts"=>{:type=>:integer,:pretty_name=>"Minimum number of characters per post. (Min: 5)",:default=>6,:group=>"General",:min=>5,:max=>65535},
    "external_link_warning"=>{:type=>:boolean,:pretty_name=>"All external links go to an external link warning page instead of the link.",:default=>false,:group=>"General"},
    "infraction_expiry"=>{:type=>:integer,:pretty_name=>"Number of days until one infraction point expires: (0 to disable all infractions)",:default=>0,:group=>"General"},
    "allow_bold"=>{:type=>:boolean,:pretty_name=>"Allow bolded text.",:default=>true,:group=>"Styling"},
    "allow_italics"=>{:type=>:boolean,:pretty_name=>"Allow italic text.",:default=>true,:group=>"Styling"},
    "allow_underline"=>{:type=>:boolean,:pretty_name=>"Allow underlined text.",:default=>true,:group=>"Styling"},
    "allow_strikethrough"=>{:type=>:boolean,:pretty_name=>"Allow strikethroughed text.",:default=>true,:group=>"Styling"},
    "allow_super_sub_script"=>{:type=>:boolean,:pretty_name=>"Allow superscripted/subscripted text.",:default=>true,:group=>"Styling"},
    "allow_color"=>{:type=>:boolean,:pretty_name=>"Allow colored text.",:default=>true,:group=>"Styling"},
    "allow_size"=>{:type=>:boolean,:pretty_name=>"Allow resized text.",:default=>true,:group=>"Styling"},
    "allow_align"=>{:type=>:boolean,:pretty_name=>"Allow text alignment. (left,center,right,justified)",:default=>true,:group=>"Styling"},
    "allow_fancy_styling"=>{:type=>:boolean,:pretty_name=>"Allow fancy features of Textile text such as letter-spacing, text-shadow.",:default=>true,:group=>"Styling"},
    "signature_max_lines"=>{:type=>:integer,:pretty_name=>"SIGNATURE: Maximum number of lines for a signature.",:default=>3,:group=>"User"},
    "signature_max_chars_per_line"=>{:type=>:integer,:pretty_name=>"SIGNATURE: Maximum number of characters per line for a signature.",:default=>100,:group=>"User"},
    "sprite_max_width"=>{:type=>:integer,:pretty_name=>"SPRITE: Max width of user selectable image next to user on posts.",:default=>20,:group=>"User"},
    "sprite_max_height"=>{:type=>:integer,:pretty_name=>"SPRITE: Max height of user selectable image next to user on posts.",:default=>32,:group=>"User"},
    "inbox_limit"=>{:type=>:integer,:pretty_name=>"PRIVATE MESSAGES: Inbox size. Does not apply to mods or admins. (0 for unlimited)",:default=>0,:group=>"User"}
  }
  
  def ensure_min_max_values
    pref = PREFERENCES[self.name]
    self.value = pref[:max] if self.value > pref[:max] if self.value && pref[:max]
    self.value = pref[:min] if self.value < pref[:min] if self.value && pref[:min]
  end
  
  def self.find(*args)
    if args.length == 1 && args.first.is_a?(String) && PREFERENCES.has_key?(args.first)
      cached_response = CACHE.get "system_pref_#{args.first}" unless CACHE.nil?
      if cached_response.nil?
        s = SystemPreference.find_by_name(args.first)
        res = nil
        if s.nil?
          res = PREFERENCES[args.first][:default]
        elsif PREFERENCES[args.first][:type] == :boolean
          res = s.value==1
        else
          res = s.value
        end
        CACHE.set "system_pref_#{args.first}",res unless CACHE.nil?
        return res
      else
        return cached_response
      end
    else
      super
    end
  end
  
  def admins_only
    raise SecurityException, "You are not allowed to edit system preferences!" unless $logged_in_user.has_permission("Administrator")
  end
  
  def clear_cache
    return nil if CACHE.nil?
    CACHE.delete "system_pref_#{self.name}"
  end
end
