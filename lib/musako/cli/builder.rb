module Musako
  module Cli
    class Builder
      def self.process(options)
        initialize_target_dir
        begin
          build_static_files
          build_page_files
        rescue => e
          delete_target_dir
          raise e
        end
      end

      def self.build_static_files
        # scss to css
        scss_files = File.join(Musako.assets_path, "scss", "**", "*.scss")
        Dir.glob(scss_files).each do |file|
          css = Musako::Renderers::Scss.new(file)
          css.render
        end

        # copy all static files to target directory
        FileUtils.cp_r Musako.assets_path, Musako.destination_path
      end

      def self.build_page_files
        posts = []

        # posts to html
        post_files = File.join(Musako.source_path, "posts", "**", "*.md")
        Dir.glob(post_files).each do |file|
          post = Musako::Renderers::Post.new(file)
          post.render

          posts << post
        end

        views_dir  = Musako.views_path
        posts.sort! { |a, b| b.date <=> a.date }

        index_file = File.join(views_dir, "index.slim")
        Musako::Renderers::Index.new(index_file, posts).render

        feed_file  = File.join(views_dir, "feed.builder")
        Musako::Renderers::Feed.new(feed_file, posts).render
      end

      def self.initialize_target_dir
        dest_dir = Musako.destination_path

        FileUtils.remove_entry_secure dest_dir if File.exists? dest_dir
        FileUtils.mkdir_p dest_dir
      end

      def self.delete_target_dir
        FileUtils.remove_entry_secure Musako.destination_path
      end
    end
  end
end
