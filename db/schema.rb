# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_31_164032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acls", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "action_logs", id: :serial, force: :cascade do |t|
    t.string "action", limit: 510
    t.integer "individual_id"
    t.integer "user_id"
    t.text "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alerts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "expires_at"
    t.integer "severity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "original"
    t.text "xhtml"
    t.string "group", limit: 510
    t.boolean "rawhtml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "URL", limit: 510
    t.string "comment", limit: 510
    t.string "title_tag", limit: 510
    t.string "link", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_users", id: false, force: :cascade do |t|
    t.integer "badge_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "nickname", limit: 510
    t.integer "order"
    t.index ["nickname"], name: "index_categories_on_nickname"
  end

  create_table "contests", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "default_tags", limit: 510
  end

  create_table "email_acls", id: :serial, force: :cascade do |t|
    t.string "email", limit: 510
    t.string "acl", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emblemeds", id: :serial, force: :cascade do |t|
    t.integer "emblem_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emblems", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "order"
    t.string "permission_name", limit: 510
    t.integer "group_id"
    t.string "css", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fact10_m3_ff10_days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "day_number"
    t.datetime "date"
    t.string "subtitle", limit: 510
    t.string "screenshot", limit: 510
    t.text "walkthrough"
    t.text "challenges"
    t.integer "contest_id"
    t.string "music_image_url", limit: 510
    t.string "music_url", limit: 510
    t.string "bonus_url", limit: 510
    t.integer "vimeo"
  end

  create_table "fact11_ebff10_days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "number"
    t.datetime "date"
    t.string "host_name", limit: 510
    t.string "host_url", limit: 510
    t.string "screenshot", limit: 510
    t.text "pagetext"
    t.string "bonus_name", limit: 510
    t.string "bonus_author", limit: 510
    t.string "bonus_url", limit: 510
    t.string "music_name", limit: 510
    t.string "music_author", limit: 510
    t.string "music_url", limit: 510
    t.string "music_mp3", limit: 510
    t.string "music_ogg", limit: 510
    t.string "bonus_author_url", limit: 510
    t.string "music_author_url", limit: 510
    t.integer "topic_id"
    t.string "prize_category", limit: 510
    t.text "prize_text"
    t.integer "vimeo"
  end

  create_table "fact1_enemies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "hp"
  end

  create_table "fact2_games", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "us_title", limit: 510
    t.string "system", limit: 510
    t.string "genre", limit: 510
    t.datetime "release_date"
  end

  create_table "fact3_bos", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "hp"
    t.integer "pp"
    t.integer "money"
  end

  create_table "fact4_weapons", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "buy"
    t.integer "sell"
    t.integer "offense"
    t.float "miss"
  end

  create_table "fact5_ebfgp_days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "sidebar"
  end

  create_table "fact6_ebfgp_sidebars", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "screenshot", limit: 510
    t.string "fanart_url", limit: 510
    t.string "fanart_artist", limit: 510
    t.string "fanart_artist_url", limit: 510
    t.string "fanmusic_url", limit: 510
    t.string "fanmusic_artist", limit: 510
    t.string "fanmusic_artist_url", limit: 510
    t.string "fanart_name", limit: 510
    t.string "fanmusic_name", limit: 510
  end

  create_table "fact7_ebfgp_days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "day_number"
    t.datetime "date"
    t.string "screenshot", limit: 510
    t.string "subtitle", limit: 510
    t.integer "topic_id"
    t.integer "contest_id"
  end

  create_table "fact8_halloween_funfest09s", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "contest_id"
  end

  create_table "fact9_ctff_days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "day_number"
    t.datetime "date"
    t.string "subtitle", limit: 510
    t.string "screenshot", limit: 510
    t.text "walkthrough"
    t.text "challenges"
    t.integer "contest_id"
    t.string "music_image_url", limit: 510
    t.string "music_url", limit: 510
    t.string "bonus_url", limit: 510
    t.integer "vimeo"
  end

  create_table "fact_fields", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "kind", limit: 510
    t.integer "fact_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fact_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_advanced_permissions", id: :serial, force: :cascade do |t|
    t.integer "forum_id"
    t.text "body_registered"
    t.text "body_unregistered"
    t.string "webhook_xml_parse_key", limit: 510
    t.string "webhook_xml_parse_model", limit: 510
    t.string "webhook_xml_parse_condition", limit: 510
    t.string "webhook_xml_parse_condition_key", limit: 510
    t.string "acl", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "forum_attachments" because of following StandardError
#   Unknown type 'forum_attachments_thumbnail' for column 'thumbnail'

  create_table "forum_preferences", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "preference"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_reads", primary_key: ["forum_id", "user_id"], force: :cascade do |t|
    t.integer "forum_id", default: 0, null: false
    t.integer "user_id", default: 0, null: false
    t.datetime "last_view"
  end

  create_table "forum_tabs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "link"
    t.integer "forum_id"
    t.integer "sprite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "top"
    t.float "left"
  end

  create_table "forums", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "tagline"
    t.boolean "read_by_column"
    t.boolean "read_require_login"
    t.boolean "post_reply"
    t.string "require_acl", limit: 510
    t.boolean "require_first_key"
    t.integer "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "post_new_topic"
    t.integer "post_count"
    t.datetime "last_message"
    t.boolean "mod_forum"
    t.integer "sprite_id"
    t.string "nickname", limit: 510
    t.boolean "allow_images"
    t.boolean "hidden"
    t.integer "order"
    t.boolean "disable_listing_on_forumspy"
    t.boolean "disable_polls"
    t.boolean "serious_business"
    t.boolean "allow_attachments", null: false
    t.boolean "disable_swear_filter"
    t.index ["category_id"], name: "index_forums_on_category_id"
    t.index ["nickname"], name: "index_forums_on_nickname"
  end

  create_table "forums_sites", id: false, force: :cascade do |t|
    t.integer "forum_id"
    t.integer "site_id"
  end

  create_table "friends", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
  end

  create_table "games_sprites", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "sprite_id"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "comment", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_groups", id: false, force: :cascade do |t|
    t.integer "group1"
    t.integer "group2"
  end

  create_table "groups_raw_permissions", id: :serial, force: :cascade do |t|
    t.integer "group_id"
    t.integer "raw_permission_id"
    t.integer "individual_id"
    t.boolean "value"
  end

  create_table "groups_users", primary_key: ["group_id", "user_id"], force: :cascade do |t|
    t.integer "group_id", default: 0, null: false
    t.integer "user_id", default: 0, null: false
  end

  create_table "infraction_groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infraction_punishment_punishments", id: :serial, force: :cascade do |t|
    t.integer "infraction_punishment_id"
    t.string "name", limit: 510
    t.integer "expire_seconds"
    t.string "expire_input", limit: 510
    t.boolean "until_points_expire"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infraction_punishments", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "points"
    t.boolean "disable_point_expiration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infractions", id: :serial, force: :cascade do |t|
    t.text "reason"
    t.integer "user_id"
    t.integer "message_id"
    t.integer "mod_id"
    t.text "resolution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "case_taken_time"
    t.datetime "resolved_at"
    t.integer "resolution_by"
    t.string "punishment", limit: 510
    t.integer "infraction_group_id"
    t.boolean "deleted_message", null: false
    t.boolean "locked_topic", null: false
    t.integer "moved_topic_to"
    t.datetime "ban_from_topic_until"
    t.integer "report_forum_id"
  end

  create_table "infractions_old", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "mod_action", limit: 510
    t.integer "mod"
    t.text "reason"
    t.integer "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "points"
  end

  create_table "ip_bans", id: :serial, force: :cascade do |t|
    t.string "ip_address", limit: 510
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expired_at"
  end

  create_table "layouts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "body_original"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "template_id"
    t.integer "template2_id"
    t.text "main_css"
    t.string "main_css_type", limit: 510
    t.text "ie7_css"
    t.string "ie7_css_type", limit: 510
    t.text "ie6_css"
    t.string "ie6_css_type", limit: 510
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "topic_id"
    t.text "body"
    t.text "body_original"
    t.integer "user_id"
    t.string "ip_address", limit: 510
    t.string "hostname", limit: 510
    t.integer "edited_by"
    t.boolean "deleted", null: false
    t.boolean "show_sig"
    t.boolean "locked"
    t.string "thumbnail", limit: 510
    t.string "thumbnail_ids", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "poll_id"
    t.integer "score"
    t.boolean "disable_smilies"
    t.boolean "disable_textile"
    t.integer "emblem_id"
    t.integer "deleted_by"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["topic_id"], name: "index_messages_on_topic_id"
  end

  create_table "messages_searchwords", id: false, force: :cascade do |t|
    t.integer "message_id"
    t.integer "searchword_id"
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "body"
    t.text "body_original"
    t.text "jump"
    t.text "jump_original"
    t.integer "sticky"
    t.integer "user_id"
    t.integer "updater_id"
    t.integer "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "forum_news"
  end

  create_table "oauth_customers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "url", limit: 510
    t.string "callback_url", limit: 510
    t.string "key", limit: 510
    t.string "secret", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_nonces", id: :serial, force: :cascade do |t|
    t.string "nonce", limit: 510
    t.integer "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["nonce", "timestamp"], name: "oauth_nonces_nonce_timestamp_key", unique: true
  end

  create_table "old_pms", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.text "body_original"
    t.text "body"
    t.integer "owner_id"
    t.integer "sender_id"
    t.string "sendto", limit: 510
    t.boolean "read"
    t.integer "infraction_id"
    t.integer "root_id"
    t.datetime "last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_histories", id: :serial, force: :cascade do |t|
    t.text "body_original"
    t.text "body"
    t.integer "user_id"
    t.integer "revision"
    t.boolean "page_not_file"
    t.string "dir1", limit: 510
    t.string "dir2", limit: 510
    t.string "dir3", limit: 510
    t.string "dir4", limit: 510
    t.string "dir5", limit: 510
    t.string "format", limit: 510
    t.integer "layout_id"
    t.integer "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "fact_type_id"
    t.string "name", limit: 510
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.text "body_original"
    t.text "body"
    t.integer "user_id"
    t.integer "revision", default: 1
    t.boolean "page_not_file"
    t.string "dir1", limit: 510
    t.string "dir2", limit: 510
    t.string "dir3", limit: 510
    t.string "dir4", limit: 510
    t.string "dir5", limit: 510
    t.string "format", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "layout_id"
    t.integer "fact_type_id"
    t.string "name", limit: 510
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.string "permission", limit: 510
    t.boolean "value"
    t.integer "user_id"
    t.integer "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["permission", "user_id", "individual_id"], name: "permissions_permission_user_id_individual_id_key", unique: true
    t.index ["permission", "value", "user_id", "individual_id"], name: "permissions_permission_value_user_id_individual_id_key", unique: true
  end

  create_table "points", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "infraction_id"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "option0"
    t.text "option1"
    t.text "option2"
    t.text "option3"
    t.text "option4"
    t.text "option5"
    t.text "option6"
    t.text "option7"
    t.text "option8"
    t.text "option9"
    t.integer "user_id"
    t.boolean "multiple"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "private_messages", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
    t.text "body_original"
    t.text "body"
    t.integer "owner_id"
    t.integer "sender_id"
    t.string "sendto", limit: 510
    t.boolean "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "infraction_id"
    t.integer "root_id"
    t.datetime "last_update"
    t.integer "foff"
    t.integer "length"
    t.boolean "hidden_in_inbox", null: false
    t.boolean "hidden_in_sent_box", null: false
  end

  create_table "punishments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "giver_id"
    t.text "reason"
    t.datetime "until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 510
    t.integer "individual_id"
    t.integer "infraction_punishment_id"
  end

  create_table "raw_permissions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.text "comment"
    t.string "model", limit: 510
    t.string "option", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "unit", limit: 510
    t.string "individual_desc", limit: 510
  end

  create_table "raw_permissions_groups", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "raw_permission_id"
    t.integer "individual_id"
    t.boolean "value"
  end

  create_table "raw_permissions_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "raw_permission_id"
    t.integer "individual_id"
    t.boolean "value", null: false
  end

  create_table "reads", id: :serial, force: :cascade do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.integer "message_id"
    t.datetime "last_view"
    t.index ["user_id", "topic_id"], name: "index_reads_on_user_id_and_topic_id", unique: true
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "mod_id"
    t.datetime "resolved_at"
    t.string "resolution_kind", limit: 510
    t.integer "message_id"
    t.text "body"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", id: :serial, force: :cascade do |t|
    t.text "body"
    t.text "body_original"
    t.integer "updated_by"
    t.integer "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searchwords", id: :serial, force: :cascade do |t|
    t.string "word", limit: 510
  end

  create_table "secret_keys", id: :serial, force: :cascade do |t|
    t.string "key", limit: 510
    t.integer "uses"
    t.integer "used"
    t.string "comment", limit: 510
    t.string "acl", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "shortname", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "domain", limit: 510
    t.string "class_name", limit: 510
    t.boolean "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "root", limit: 510
    t.string "google_analytics", limit: 510
    t.integer "layout_id"
    t.index ["domain"], name: "sites_domain_key", unique: true
  end

  create_table "smilies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "regexp", limit: 510
    t.string "url", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sphinx_deltas", id: :serial, force: :cascade do |t|
    t.integer "max_id"
  end

  create_table "sprite_tag_habtm", id: false, force: :cascade do |t|
    t.integer "sprite_id"
    t.integer "sprite_tag_id"
  end

  create_table "sprite_tags", id: :serial, force: :cascade do |t|
    t.string "title", limit: 510
  end

  create_table "sprites", id: :serial, force: :cascade do |t|
    t.integer "size"
    t.string "content_type", limit: 510
    t.string "filename", limit: 510
    t.integer "height"
    t.integer "width"
    t.string "title", limit: 510
    t.boolean "visibility"
    t.integer "requires_group_id"
  end

  create_table "style_elements", id: :serial, force: :cascade do |t|
    t.integer "style_id"
    t.string "kind", limit: 510
    t.text "haml_original"
    t.integer "fact_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "styles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submission_tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "submission_id"
    t.string "permalink", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 510
    t.integer "parent_id"
    t.string "content_type", limit: 510
    t.string "filename", limit: 510
    t.text "URL"
    t.text "desc"
    t.string "thumbnail", limit: 510
    t.integer "size"
    t.integer "width"
    t.integer "height"
    t.integer "score"
    t.integer "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "permalink", limit: 510
    t.string "kind", limit: 510
    t.integer "contest_id"
    t.integer "message_id"
    t.integer "uploaded_image_id"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "topic_id"], name: "index_subscriptions_on_user_id_and_topic_id"
  end

  create_table "swear_words", id: :serial, force: :cascade do |t|
    t.string "word", limit: 510
    t.boolean "case_sensitive"
    t.string "mask", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "simple"
  end

  create_table "system_announcements", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 510
    t.text "body_original"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_preferences", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.integer "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.text "code"
    t.string "code_type", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "layout_id"
    t.string "name", limit: 510
    t.text "wrapper"
  end

  create_table "themes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "url", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thumbs", id: :serial, force: :cascade do |t|
    t.integer "score"
    t.integer "user_id"
    t.integer "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.integer "forum_id"
    t.string "name", limit: 510
    t.integer "user_id"
    t.datetime "last_message"
    t.integer "latest_message_id"
    t.boolean "locked"
    t.integer "replies"
    t.integer "views"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sticky", default: 0
    t.integer "sprite_id"
    t.string "byline", limit: 510
    t.string "permalink", limit: 510
    t.string "kind", limit: 510
    t.integer "contest_id"
    t.integer "emblem_id"
    t.string "original_name", limit: 510
    t.string "original_byline", limit: 510
    t.index ["forum_id"], name: "index_topics_on_forum_id"
    t.index ["permalink"], name: "index_topics_on_permalink"
  end

  create_table "uploaded_images", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.string "content_type", limit: 510
    t.string "filename", limit: 510
    t.string "thumbnail", limit: 510
    t.integer "size"
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "passhash", limit: 510
    t.string "salt", limit: 510
    t.boolean "banned"
    t.text "ban_reason"
    t.text "signature"
    t.text "signature_original"
    t.boolean "has_first_key"
    t.string "first_key", limit: 510
    t.string "first_key_salt", limit: 510
    t.boolean "super_user"
    t.boolean "show_sig_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "avatar_xhtml"
    t.text "badge_xhtml"
    t.datetime "last_visit"
    t.integer "emblem_id", default: 0
    t.text "info"
    t.integer "sprite_id"
    t.boolean "disable_smilies_default"
    t.string "permalink", limit: 510
    t.string "email", limit: 510
    t.boolean "seen_rules"
    t.string "email_validation", limit: 510
    t.string "rank", limit: 510
    t.text "oldbadges"
    t.boolean "disable_textile_default"
    t.integer "theme_id", default: 1
    t.boolean "invisible"
    t.string "password_confirmation", limit: 64
    t.text "preferences"
    t.string "timezone", limit: 510
    t.boolean "email_subscriptions"
    t.boolean "email_pms"
    t.boolean "hide_thumbing"
    t.boolean "hide_avatars"
    t.boolean "hide_signatures"
    t.boolean "immune_to_alerts"
    t.string "registration_ip", limit: 510
    t.text "sb_avatar"
    t.integer "points"
    t.datetime "next_point_expiration"
    t.integer "infraction_punishment_id"
    t.index ["name"], name: "index_users_on_name"
  end

  create_table "users_copy", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510
    t.string "passhash", limit: 510
    t.string "salt", limit: 510
    t.boolean "banned"
    t.text "ban_reason"
    t.text "signature"
    t.text "signature_original"
    t.boolean "has_first_key"
    t.string "first_key", limit: 510
    t.string "first_key_salt", limit: 510
    t.boolean "super_user"
    t.boolean "show_sig_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "avatar_xhtml"
    t.text "badge_xhtml"
    t.datetime "last_visit"
    t.integer "color", default: 0
    t.text "info"
    t.integer "sprite_id"
    t.boolean "disable_smilies_default"
    t.string "permalink", limit: 510
    t.string "email", limit: 510
    t.boolean "seen_rules"
    t.string "email_validation", limit: 510
  end

  create_table "variable_conditions", id: :serial, force: :cascade do |t|
    t.integer "variable_id"
    t.string "operand", limit: 510
    t.string "operator", limit: 510
    t.string "item", limit: 510
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variables", id: :serial, force: :cascade do |t|
    t.string "name", limit: 510, default: "new"
    t.string "klass", limit: 510, default: "submissions"
    t.integer "offset"
    t.integer "limit"
    t.string "order", limit: 510
    t.integer "page_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "poll_id"
    t.integer "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
