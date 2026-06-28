;lua
(
 (comment) @cmt
 (#match? @cmt "//\\s?luacode")
 .
 (const_declaration 
   (const_spec
	 name: (identifier) 
	 value: (expression_list
			  (raw_string_literal) @injection.content)))
 (#set! injection.language "lua"))


(
 (comment) @cmt
 (#match? @cmt "//\\s?luacode")
 .
(short_var_declaration
	left: (expression_list
		(identifier))
    	right: (expression_list
      	(call_expression
        	function: (selector_expression
          	operand: (identifier)
            field: (field_identifier))
            arguments: (argument_list 
            	(raw_string_literal) @injection.content))))
 (#set! injection.language "lua"))


;sql
(
 (comment) @cmt
 (#eq? @cmt "//sqlcode")
 .
 (const_declaration 
   (const_spec
	 name: (identifier) 
	 value: (expression_list
			  (raw_string_literal) @injection.content)))
 (#set! injection.language "sql"))


; gotmpl
(
 (comment) @cmt
 (#match? @cmt "//\\s?gotmpl")
 .
 (const_declaration 
   (const_spec
     name: (identifier) 
     value: (expression_list
              (raw_string_literal) @injection.content)))
 (#set! injection.language "gotmpl"))
