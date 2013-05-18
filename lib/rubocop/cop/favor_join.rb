# encoding: utf-8

module Rubocop
  module Cop
    class FavorJoin < Cop
      MSG = 'Favor Array#join over Array#*.'

      def inspect(file, source, tokens, sexp)
        on_node(:send, sexp) do |s|
          receiver_node, method_name, *arg_nodes = *s

          if receiver_node && receiver_node.type == :array &&
              method_name == :* && arg_nodes[0].type == :str
            add_offence(:convention,
                        s.src.expression.line,
                        MSG)
          end
        end
      end
    end
  end
end