# frozen_string_literal: true

require "i18n/tasks/scanners/file_scanner"
require "byebug"

class ComponentScanner < I18n::Tasks::Scanners::FileScanner
  include I18n::Tasks::Scanners::RelativeKeys
  include I18n::Tasks::Scanners::OccurrenceFromPosition

  def scan_file(path)
    text = read_file(path)
    keys = text.scan(/^\s*=\s*card :(\w+)\b/).map do |match|
      occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
      [absolute_key(".#{match.first}", path), occurrence]
    end
    keys += text.scan(/^\s*=\s*\w\.submit_line "\.(\w+)\b/).map do |match|
      occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
      [absolute_key(".#{match.first}", path), occurrence]
    end
    keys
  end
end

I18n::Tasks.add_scanner "ComponentScanner", only: ["*.haml", "*.slim"]

class ActiveModelScanner < I18n::Tasks::Scanners::FileScanner
  include I18n::Tasks::Scanners::RelativeKeys
  include I18n::Tasks::Scanners::OccurrenceFromPosition

  def scan_file(path)
    return [] unless path.include? "app/forms"

    text = read_file(path)
    form = path.sub("app/forms/", "").sub(".rb", "")
    return [] unless form.include? "_form"

    text.scan(/^\s*attribute :(\w+)\b/).map do |match|
      match = match&.first
      next if match.blank? || ["_destroy", "id"].include?(match)

      occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
      ["activemodel.attributes.#{form}.#{match}", occurrence]
    end.compact
  end
end

I18n::Tasks.add_scanner "ActiveModelScanner", only: ["*.rb"]

class ActiveRecordScanner < I18n::Tasks::Scanners::FileScanner
  include I18n::Tasks::Scanners::RelativeKeys
  include I18n::Tasks::Scanners::OccurrenceFromPosition

  def scan_file(path)
    text = read_file(path)
    keys = text.scan(/^.*\s+(\w+(?::|\w)+).human_attribute_name(?:\(|\s):(\w+)\b/).map do |match|
      model = match.first.underscore
      attribute = match.last
      occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
      ["activerecord.attributes.#{model}.#{attribute}", occurrence]
    end.compact
    if path.include?("app/models")
      keys += text.scan(/^\s*class (\w+) < \w+/).flat_map do |match|
        match = match&.first
        next if match.blank?

        model = path.sub("app/models/", "").sub(".rb", "")
        occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
        [["activerecord.models.#{model}.one", occurrence], ["activerecord.models.#{model}.other", occurrence]]
      end.compact
    end
    keys
  end
end

I18n::Tasks.add_scanner "ActiveRecordScanner", only: ["*.slim", "*.rb"]

class JSXScanner < I18n::Tasks::Scanners::FileScanner
  include I18n::Tasks::Scanners::RelativeKeys
  include I18n::Tasks::Scanners::OccurrenceFromPosition

  def scan_file(path)
    text = read_file(path)
    return [] unless text =~ /class (\w+)\b/

    component = text.match(/class (\w+)\b/)[1].to_s.underscore
    text.scan(/this.t\(.((?:\w|\.)+)\b/).map do |match|
      key = match&.first
      next if key.blank?

      occurrence = occurrence_from_position(path, text, Regexp.last_match.offset(0).first)
      ["component.#{component}.#{key}", occurrence]
    end.compact
  end
end

I18n::Tasks.add_scanner "JSXScanner", only: ["*.jsx", "app/javascript/admin/components/*.js"]
