module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = ['public', 'private', 'archived', 'spam']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do
    def public_count
      where(status: 'public').count
    end
  end

  def public?
    status == 'archived'
  end

  def archived?
    status == 'archived'
  end

  def private?
    status == 'private'
  end

  def spam?
    status == 'spam'
  end
end
