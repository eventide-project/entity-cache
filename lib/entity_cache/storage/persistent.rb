class EntityCache
  module Storage
    module Persistent
      def self.included(cls)
        cls.class_exec do
          extend Build

          initializer :subject

          virtual :configure
        end
      end

      module Build
        def build(subject, session: nil)
          instance = new(subject)
          instance.configure(session: session)
          instance
        end
      end
    end
  end
end
