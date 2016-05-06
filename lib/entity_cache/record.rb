class EntityCache
  class Record < Struct.new :id, :entity, :version, :time, :persistent_version, :persistent_time
    def age
      persistent_version = self.persistent_version
      persistent_version ||= -1

      version - persistent_version.to_i
    end

    def destructure(includes=nil)
      return entity if includes.nil?

      responses = [entity]
      
      includes = Array(includes)

      includes.each do |attribute|
        value = public_send attribute

        value = NoStream.version if value.nil? && attribute == :version

        responses << value
      end

      responses
    end

    module NoStream
      def self.destructure(includes=nil)
        record = Record.new
        record.destructure includes
      end

      def self.version
        :no_stream
      end
    end
  end
end
