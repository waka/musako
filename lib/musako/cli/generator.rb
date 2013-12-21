module Musako
  module Cli
    class Generator
      def self.process(args)
        if args.empty?
          args = ["."]
        end

        path = File.expand_path(args[0], Dir.pwd)

        if !Dir["#{path}/posts"].empty?
          raise "Error: musako project exists and is not empty."
        end

        create_templates path
      end

      private

      def self.create_templates(path)
        t = template
        FileUtils.cp_r t + '/.', path
      end

      def self.template
        File.expand_path("../../templates", File.dirname(__FILE__))
      end
    end
  end
end
