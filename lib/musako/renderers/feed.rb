require "tilt"
require "builder"

module Musako
  module Renderers
    class Feed < Renderer
      attr_accessor :posts

      def initialize(file, posts)
        super file
        @file_extname = ".xml"
        @posts = posts
      end

      def render
        contents = Tilt.new(
          File.join(Musako.views_path, "feed.builder")
        ).render(self, {posts: @posts, config: Musako.configuration})

        File.open(self.output_path, "w") do |file|
          file.write contents
        end
      end

      def output_path
        File.join(Musako.destination_path, self.file_name)
      end
    end
  end
end
