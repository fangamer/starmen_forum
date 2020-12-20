class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :name
      t.string :passhash
      t.string :salt
      t.boolean :banned
      t.text :ban_reason
      t.text :signature
      t.text :signature_original
      t.boolean :has_first_key
      t.string :first_key
      t.string :first_key_salt
      t.boolean :super_user
      t.boolean :show_sig_default
      t.text :avatar_xhtml
      t.text :badge_xhtml
      t.datetime :last_visit
      t.integer :emblem_id,default:0
      t.text :info
      t.integer :sprite_id
      t.boolean :disable_smilies_default,default:false
      t.string :permalink
      t.string :email
      t.boolean :seen_rules
      t.string :email_validation
      t.string :rank
      t.text :oldbadges
      t.boolean :disable_textile_default
      t.integer :theme_id, default:1
      t.boolean :invisible, default: false
      t.string :password_confirmation, limit:32
      t.text :preferences
      t.string :timezone
      t.boolean :email_subscriptions
      t.boolean :email_pms
      t.boolean :hide_thumbing, default: false
      t.boolean :hide_avatars
      t.boolean :hide_signatures
      t.boolean :immune_to_alerts
      t.string :registration_ip
      t.text :sb_avatar
      t.integer :points
      t.datetime :next_point_expiration
      t.integer :infraction_punishment_id

      t.timestamps
    end
  end
end
