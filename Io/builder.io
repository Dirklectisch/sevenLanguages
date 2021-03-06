curlyBrackets := method(

  attrs := List clone
  attrString := ""

  call message arguments foreach(arg,
	attrs append(
		arg asSimpleString split(":")
	)
  )

  attrs foreach(attr,
	attrString = attrString with(
	    " ", 
		attr at(0) asMutable strip removePrefix("\"") removeSuffix("\""),
		"=",
		attr at(1) strip
		) 	
  )

  attrString

)

Builder := Object clone

Builder depth := -1
Builder indentChar := " "

Builder forward := method(
	
	self depth := self depth + 1
	args := call message arguments clone
	
	indent := ""
	for(i, 1, depth,
		indent = indent with(indentChar)
	)
	
	if(call argAt(0) name == "curlyBrackets",
		attrString := doMessage(args removeFirst),
		attrString := ""
	)
	
	writeln(indent, "<", call message name, attrString, ">")
	args foreach(arg,
		content := self doMessage(arg);
		if(content type == "Sequence", writeln(indent with(indentChar), content))
	)

	writeln(indent, "</", call message name, ">")
	
	self depth := self depth - 1
)

Builder ul(	
			{
				"aap": "beer",
				"noot": "meeuw"
			},			
			li("Io"), 
			li("Lua"), 
			li("JavaScript")
	 	)



