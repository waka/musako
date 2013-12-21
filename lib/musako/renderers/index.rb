require 'slim'

module Musako
  module Renderers
    class Index < Renderer
      attr_accessor :posts

      def initialize(file, posts)
        super file

        @file_extname = ".html"
        @posts = posts
      end

      def render
        contents = Slim::Template.new(
          File.join(Musako.views_path, "index.slim")
        ).render(self, {posts: @posts, config: Musako.configuration})

        layout = Slim::Template.new(
          File.join(Musako.views_path, "layouts", "application.slim")
        ).render(self, {title: Musako.configuration[:title]}) { contents }

        File.open(self.output_path, "w") do |file|
          file.write layout
        end
      end

      def output_path
        File.join(Musako.destination_path, self.file_name)
      end
    end
  end
end
