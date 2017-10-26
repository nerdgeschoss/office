module FormattingHelper
  def parentheses(value)
    return "" unless value
    safe_join ["(", value, ")"]
  end

  def date_range(*dates)
    dates = dates.map(&:to_date).uniq
    dates.map.with_index { |e, index| l(e, format: index == dates.count - 1 ? :default : :short) }
      .join " - "
  end

  def number_to_accounting(number)
    sign = number.to_f < 0 ? "−" : "+"
    safe_join [number_to_currency(number.to_f.abs), sign], "\xC2\xA0"
  end

  def image_data_url(blob)
    "data:image/svg+xml;base64,#{Base64.encode64(blob)}"
  end
end