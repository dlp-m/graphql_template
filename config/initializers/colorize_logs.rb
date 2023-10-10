# frozen_string_literal: true

colorize_logs_formatter = ColorizeLogs::Formatter.new

colorize_logs_formatter.configure do
  match(/Processing by/) do |msg|
    msg.red
  end

  match(/Rendering layout/) do |msg|
    msg.green
  end

  match(/Rendering.*within layouts/) do |msg|
    msg.green
  end
end

::Rails.logger.formatter = colorize_logs_formatter
