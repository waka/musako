require 'pygments'

module Musako
  # from https://github.com/vmg/redcarpet
  class HtmlWithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end
end
