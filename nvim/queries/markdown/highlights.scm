[
  (atx_heading
    (atx_h1_marker))
] @text.title1

[
  (atx_heading
    (atx_h2_marker))
] @text.title2

[
  (atx_heading
    (atx_h3_marker))
] @text.title3

[
  (atx_heading
    (atx_h4_marker))
] @text.title4

[
  (atx_heading
    (atx_h5_marker))
] @text.title5

[
  (atx_heading
    (atx_h6_marker))
] @text.title6

[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @text.literal

(pipe_table_header (pipe_table_cell) @text.title)

(pipe_table_header "|" @punctuation.special)
(pipe_table_row "|" @punctuation.special)
(pipe_table_delimiter_row "|" @punctuation.special)
(pipe_table_delimiter_cell) @punctuation.special

[
  (fenced_code_block_delimiter)
] @punctuation.delimiter

(code_fence_content) @none

[
  (link_destination)
] @text.uri

[
  (link_label)
] @text.reference

[
  (thematic_break)
  (list
    (list_item
      (list_marker_minus)
      (paragraph
        (inline))))
  (list
    (list_item
      (list_marker_plus)
      (paragraph
        (inline))))
  (list
    (list_item
      (list_marker_star)
      (paragraph
        (inline))))
  (list
    (list_item
      (list_marker_dot)
      (paragraph
        (inline))))
  (list
    (list_item
      (list_marker_parenthesis)
      (paragraph
        (inline))))
] @punctuation.special2



; (task_list_marker_unchecked) @text.todo.unchecked
; (task_list_marker_checked) @text.todo.checked

(list_item
  (task_list_marker_checked)
  (paragraph
    (inline))) @text.todo.checked

(list_item
  (task_list_marker_unchecked)
  (paragraph
    (inline))) @text.todo.unchecked

(block_quote) @text.quote

[
  (block_continuation)
  (block_quote_marker)
] @punctuation.special

[
  (backslash_escape)
] @string.escape

([
  (info_string)
  (fenced_code_block_delimiter)
] @conceal
(#set! conceal ""))

(inline) @spell
