; (
;   (assignment_expression
;     left: (member_expression
;       object: (identifier) "."
;       property: (property_identifier) @prop
;     ) "="

;     right: (template_string "`" "`") @injection.content
;   )
;   (#match? @prop "^(innerHTML|outerHTML)$")
;   (#set! injection.language "html")
; )

(
  (assignment_expression
    left: (member_expression
      object: (identifier)
      property: (property_identifier) @prop
    )
    right: (template_string) @injection.content
  )
  (#match? @prop "^(innerHTML|outerHTML)$")
  (#set! injection.language "html")
)
