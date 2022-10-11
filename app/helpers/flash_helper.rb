# frozen_string_literal: true

module FlashHelper
  def classes_for_flash(key)
    if %w[error alert].include?(key)
      'red'
    else
      'green'
    end
  end
end
