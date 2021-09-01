module Visible
  extend ActiveSupport::Concern

  # hash of valid statuses for articles or comments
  VALID_STATUSES = ['public', 'private', 'archived', 'spam']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do

    # allow counting articles or comments
    def public_count
      where(status: 'public').count
    end
  end

  # is entity public?
  def public?
    status == 'public'
  end

  # is entity archived?
  def archived?
    status == 'archived'
  end

  # is entity private?
  def private?
    status == 'private'
  end

  # is entity spam?
  def spam?
    status == 'spam'
  end
end
