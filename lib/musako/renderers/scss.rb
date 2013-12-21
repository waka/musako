require 'sass'

module Musako
  module Renderers
    class Scss < Renderer
      def initialize(file)
        super file
        @file_extname = ".css"
      end

      def render
        compiled = Sass::Engine.new(self.original_file_source, syntax: :scss)
                               .render
        File.open(self.output_path, "w") do |file|
          file.write compiled
        end
      end

      def output_path
        File.join(Musako.assets_path, "stylesheets", self.file_name)
      end
    end
  end
end
