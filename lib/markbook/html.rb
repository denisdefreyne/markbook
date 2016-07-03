module MarkBook
  class HTML < DMark::Translator
    def handle_string(string, _context)
      [html_escape(string)]
    end

    def handle_element(element, context)
      case element.name
      when 'p', 'dt', 'dd', 'ol', 'ul', 'li', 'code', 'kbd', 'blockquote', 'em'
        wrap(element.name) { handle_children(element, context) }
      when 'dl'
        if element.attributes['compact']
          wrap(element.name, class: 'compact') { handle_children(element, context) }
        else
          wrap(element.name) { handle_children(element, context) }
        end
      when 'h'
        depth = context.fetch(:depth, 1)
        wrap("h#{depth}") do
          before =
            if depth == 1
              []
            else
              wrap('a', href: '#' + id_for_header(element), class: 'permalink') { ['#'] }
            end

          [before, handle_children(element, context)]
        end
      when 'section'
        new_context = context.merge(depth: context.fetch(:depth, 1) + 1)
        wrap('section', id: id_for_section(element)) { handle_children(element, new_context) }
      when 'firstterm', 'prompt', 'filename'
        wrap('span', class: element.name) { handle_children(element, context) }
      when 'note', 'todo'
        wrap('div', class: element.name) { handle_children(element, context) }
      when 'link'
        wrap('a', href: element.attributes['target']) { handle_children(element, context) }
      when 'listing'
        wrap('pre') do
          wrap('code') do
            addition = translate(element.children, context)

            if element.attributes['lang']
              formatter = ::Rouge::Formatters::HTML.new(wrap: false)
              lexer = ::Rouge::Lexer.find(element.attributes['lang'])
              raise "Can’t find lexer for #{element.attributes['lang']}" if lexer.nil?

              formatter.format(lexer.lex(html_unescape(addition)))
            else
              addition
            end
          end
        end
      else
        raise "Unhandled element name: #{element.name}"
      end
    end

    def wrap(name, params = {})
      params_string = params.map { |k, v| " #{k}=\"#{html_escape(v)}\"" }.join('')
      ["<#{name}#{params_string}>", yield, "</#{name}>"]
    end

    def html_escape(s)
      s.gsub('&', '&amp;').gsub('<', '&lt;')
    end

    # FIXME: ugly that we need this
    def html_unescape(s)
      s.gsub('&lt;', '<').gsub('&amp;', '&')
    end

    def id_for_section(element)
      id_for_header(element.children.find { |c| c.name == 'h' })
    end

    def id_for_header(element)
      element.children.join('').downcase.gsub(/[^a-zA-Z-]/, '-')
    end
  end
end
