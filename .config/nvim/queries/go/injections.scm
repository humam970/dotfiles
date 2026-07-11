;sql
; (
;  (comment) 
;  (#match? @cmt "//\\s?sqlcode")
;  .
;  (const_declaration 
;    (const_spec 
; 	 name: (identifier) 
; 	 value: (expression_list 
; 			  (raw_string_literal 
; 				(raw_string_literal_content) @injection.content)))) 
;
;  (#set! injection.language "sql")
;  )
