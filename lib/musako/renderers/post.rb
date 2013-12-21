require 'slim'
require 'redcarpet'

module Musako
  module Renderers
    class Post < Renderer
      attr_reader :html, :title, :date, :iso_date, :url, :path

      def initialize(file)
        super file
        @file_extname = ".html"
      end

      def render
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :autolink => true,
          :space_after_headers => true,
          :fenced_code_blocks => true
        )
        @html = markdown.render(self.original_file_source)

        # use first header tag as title
        title = if @html =~ /<h1>(.*?)<\/h1>/
          $1
        else
          "No title"
        end
        self.set_meta_data(title)

        post = Slim::Template.new(
          File.join(Musako.views_path, "post.slim")
        ).render(self, {post: self, config: Musako.configuration})

        layout = Slim::Template.new(
          File.join(Musako.views_path, "layouts", "application.slim")
        ).render(self, {title: Musako.configuration[:title]}) { post }

        dir = File.dirname(self.output_path)
        unless File.directory? dir
          FileUtils.mkdir_p dir
        end

        File.open(self.output_path, "w") do |file|
          file.write layout
        end
      end

      # create directory from file's updated_at
      def output_path
        File.join(Musako.destination_path, @url)
      end

      def set_meta_data(title)
        time = self.file_updated_at

        @title = title
        @date = time
        @iso_date = time.strftime("%FT%T%z")
        @url = File.join("#{time.year}/#{time.month}/#{time.day}", self.file_name)
        @path = self.file_path
      end
    end
  end
end
