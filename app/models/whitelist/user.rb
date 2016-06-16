# frozen_string_literal: true
# == Schema Information
#
# Table name: whitelist_users
#
#  id         :integer          not null, primary key
#  email      :string(128)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_whitelist_users_on_email  (email) UNIQUE
#

class Whitelist::User < ApplicationRecord
end
