module AnimalsHelper
  
  def sti_animal_path(race = "animal", animal = nil, action = nil)
    Rails.logger.info "FIFOU #{format_sti(action, race, animal)}_path"
    method_name = "#{format_sti(action, race, animal)}_path"
    send method_name, animal
  end

  def format_sti(action, race, animal)
    action || animal ? "#{format_action(action)}#{underscore(race)}" : "#{underscore(race).pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

  # Makes an underscored, lowercase form from the expression in the string.
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # 'ActiveModel'.underscore # => "active_model"
  # 'ActiveModel::Errors'.underscore # => "active_model/errors"
  #
  # As a rule of thumb you can think of +underscore+ as the inverse of
  # +camelize+, though there are cases where that does not hold:
  #
  # 'SSLError'.underscore.camelize # => "SslError"
  def underscore(camel_cased_word)
    acronym_regex = "/(?=a)b/"
    word = camel_cased_word.to_s.gsub('::', '/')
    word.gsub!(/(?:([A-Za-z\d])|^)(#{acronym_regex})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end
