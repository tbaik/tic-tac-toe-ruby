class SerializedObjectParser
  @@KEY_VALUE_REGEX = /@([^\>@]+)/
  @@OBJECT_DELIMITER = ">, "
  @@OBJECT_START_STRING = "#<"
  @@KEY_VALUE_DELIMITER = "="
  @@MULTIPLE_VALUE_DELIMITER = ","

  class << self
    def parse_object_into_hash(objects)
      objects_hash = {}
      objects.each do |object|
        objects_hash = objects_hash.merge(parse_object_attributes(object))
      end
      return objects_hash
    end

    def parse_objects(serialized_objects)
      objects = serialized_objects.split(@@OBJECT_DELIMITER)
      objects[0] = first_object_string(objects.first)
      return objects
    end

    def parse_object_attributes(serialized_object)
      attribute_hash = {}
      key = parse_attribute_key(serialized_object)
      value = parse_attribute_value(serialized_object)
      attribute_hash[key.to_sym] = value
      return attribute_hash
    end

    def parse_attribute_key(attribute_string)
      attribute_string.split(@@KEY_VALUE_DELIMITER, 2).first.gsub("@", '')
    end

    def parse_attribute_value(attribute_string)
      value = attribute_string.split(@@KEY_VALUE_DELIMITER, 2).last
      if value.start_with?(@@OBJECT_START_STRING)
        parse_object_into_hash(value.scan(@@KEY_VALUE_REGEX).flatten)
      elsif value.include?(@@OBJECT_START_STRING)
        first_value = value.split(@@MULTIPLE_VALUE_DELIMITER, 2).first
        return first_value
      else
        cleanup_and_return_value(value)
      end
    end

    def first_object_string(object)
      object.split(' ', 2).last
    end

    def cleanup_and_return_value(value)
      if value.end_with?(", ")
        value.slice!(-2..-1)
      elsif value.end_with?(">")
        value.slice!(-1)
      end
      return value
    end
  end
end
