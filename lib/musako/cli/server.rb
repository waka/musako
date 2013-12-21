module Musako
  module Cli
    class Server
      def self.process(options)
        require 'webrick'
        include WEBrick

        unless File.exists?(options[:destination])
          p "target dir is not found"
          return
        end

        # recreate NondisclosureName under utf-8 circumstance
        fh_option = WEBrick::Config::FileHandler
        fh_option[:NondisclosureName] = ['.ht*','~*']

        s = HTTPServer.new(webrick_options(options))
        s.mount(
          "/",
          HTTPServlet::FileHandler,
          options[:destination],
          fh_option
        )

        p "Server address: http://#{s.config[:BindAddress]}:#{s.config[:Port]}"

        if options[:detach]
          # detach the server
          pid = Process.fork { s.start }
          Process.detach(pid)
          p "Server detatched with pid '#{pid}'.", "Run `kill -9 #{pid}' to stop the server."
        else
          # create a new server thread, then join it with current terminal
          t = Thread.new { s.start }
          trap("INT") { s.shutdown }
          t.join()
        end
      end

      def self.webrick_options(config)
        opts = {
          :Port => config[:port],
          :BindAddress => config[:host],
          :MimeTypes => self.mime_types,
          :DoNotReverseLookup => true,
          :StartCallback => start_callback(config[:detach])
        }

        if !config[:verbose]
          opts.merge!({
            :AccessLog => [],
            :Logger => Log::new([], Log::WARN)
          })
        end

        opts
      end

      def self.start_callback(detached)
        unless detached
          Proc.new {
            p "Server running..., press ctrl-c to stop."
          }
        end
      end

      def self.mime_types
        mime_types_file = File.expand_path(
          '../mime.types',
          File.dirname(__FILE__)
        )
        WEBrick::HTTPUtils::load_mime_types(mime_types_file)
      end
    end
  end
end
