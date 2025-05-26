module Reactable
  extend ActiveSupport::Concern

  included do
    has_many :reactions, as: :reactable, dependent: :destroy
  end

  def reaction_count_by_type
    reactions.group(:reaction_type).count
  end
end
