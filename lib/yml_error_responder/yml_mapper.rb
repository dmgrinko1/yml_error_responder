module YmlErrorResponder
  module YmlMapper
    extend self
    attr_reader :errors_handlers
    FILE_MASK = '**/*.yml'

    @errors_handlers = HashWithIndifferentAccess.new

    def error_payload(error)
      @errors_handlers[error.class.to_s]
    end

    def error_defined?(error)
      @errors_handlers.key?(error.class.to_s)
    end

    def load!
      raise 'Configuration path is not set!' if YmlErrorResponder.configuration_path.blank?

      read_dir do |path|
        add_handler(load_handlers(path, path_to_namespace(path)))
      end
    end

    def read_dir
      Dir[[YmlErrorResponder.configuration_path, FILE_MASK].join].each do |path|
        yield path
      end
    end

    def load_handlers(path, namespace)
      YAML
        .load_file(path)
        .try(:transform_keys) do |key|
          namespace.blank? ? key.to_s.camelize : [namespace, key.to_s.camelize].join('::')
        end
    end

    def path_to_namespace(path)
      path.match(/#{YmlErrorResponder.configuration_path}([^.]*)\/(.*).yml/)
        .try(:[], 1)
        .try do |match|
          match.split('/')
          .map{|m| m.camelize}
          .join('::')
        end
    end

    def add_handler(handlers)
      @errors_handlers.merge!(handlers) if handlers.present?
    end
  end
end
