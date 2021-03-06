# frozen_string_literal: true
# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  type       :integer          not null
#  title      :string(64)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  # STI使わないので `type` カラムを退避
  self.inheritance_column = :sti_type

  has_one :from_admin, class_name: 'Notification::FromAdmin'

  enum type: {
    from_admin: 1,
  }

  validates :type, :title, presence: true
end
