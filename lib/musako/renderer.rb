module Musako
  class Renderer
    def initialize(file)
      @original_file = file
    end

    # write file
    def render
      raise NoImplementationError
    end

    def file_name
      File.basename(@original_file)
          .gsub(File.extname(@original_file), self.file_extname)
    end

    def file_extname
      @file_extname || ""
    end

    def file_updated_at
      File.stat(@original_file).mtime
    end

    def file_path
      File.new(@original_file).path
    end

    def original_file_source
      File.open(@original_file, 'r').read
    end
  end
end
