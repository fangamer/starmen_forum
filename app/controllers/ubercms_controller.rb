class UbercmsController < ActionController::Base
  include Pagy::Backend

  def search
    raise if params[:q].blank?
    sanitized_query = params[:q].gsub(/[%_]/, '\\\\\0')
    arel_name = User.arel_table[:name].matches("%#{sanitized_query}%")
    arel_email = User.arel_table[:email].eq(params[:q])
    arel = arel_name.or(arel_email)
    @users = User.where(arel).limit(50)
  end
end
