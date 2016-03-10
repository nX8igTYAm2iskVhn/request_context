module RequestContext
  class Context
    attr_accessor :request_id, :user_email

    def to_hash
      hash = serialize
      hash.delete('context_class')

      hash
    end

    def serialize
      {'context_class' => self.class.name}.tap do |serialized_hash|
        self.instance_variables.each do |variable_name|
          field = variable_name.to_s[1..-1] # removes @ from variable_name
          if self.respond_to?(field)
            value = self.send(field)
            serialized_hash[field] = value unless value.nil?
          end
        end
      end
    end

    def self.deserialize(context_hash)
      if serialized_context?(context_hash)
        context = self.new
        context_hash.each { |field, value| context.send("#{field}=", value) if context.respond_to?("#{field}=") }
        context
      end
    end

    def self.serialized_context?(hash_value)
      true if hash_value.is_a?(Hash) && hash_value['context_class'] == self.name
    end
  end
end
