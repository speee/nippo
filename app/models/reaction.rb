# frozen_string_literal: true
# == Schema Information
#
# Table name: reactions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  nippo_id   :integer          not null
#  page_view  :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reactions_on_nippo_id              (nippo_id)
#  index_reactions_on_user_id               (user_id)
#  index_reactions_on_user_id_and_nippo_id  (user_id,nippo_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_4c00baa2d3  (nippo_id => nippos.id)
#  fk_rails_9f02fc96a0  (user_id => users.id)
#

class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :nippo
end
