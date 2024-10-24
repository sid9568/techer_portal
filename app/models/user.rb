class User < ApplicationRecord
  has_secure_password
  enum role: { student: 0, teacher: 1 }
  scope :search_by_keyword, ->(keyword) {
    where("LOWER(full_name) LIKE ? OR CAST(id AS TEXT) LIKE ?", "%#{keyword.downcase}%", "%#{keyword}%")
  }
end
