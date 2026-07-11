(macro_invocation 
	macro: (scoped_identifier 
		path: (identifier) @path (#eq? @path "sqlx")
		name: (identifier) @name (#match? @name "^query")
	) 
	(token_tree 
		(identifier) 
		[
 			(raw_string_literal
 				(string_content) @injection.content
 			)
 			(string_literal
 				(string_content) @injection.content
 			)
 		]

	)

   (#set! injection.language "sql")
)

(macro_invocation 
	macro: (scoped_identifier 
		path: (identifier) @path (#eq? @path "sqlx")
		name: (identifier) @name (#match? @name "^query")
	) 
	(token_tree 
		[
 			(raw_string_literal
 				(string_content) @injection.content
 			)
 			(string_literal
 				(string_content) @injection.content
 			)
 		]

	)

   (#set! injection.language "sql")
)
