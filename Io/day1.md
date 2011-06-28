## Find: ##

- Some Io example problems

        http://iolanguage.com/about/samplecode/
        
- An Io community that will answer questions
    
        http://tech.groups.yahoo.com/group/iolanguage/
        
- A style guide with Io idioms

        http://en.wikibooks.org/wiki/Io_Programming/Io_Style_Guide
        
## Answer: ##

- Evaluate 1 + 1 and then 1 + 'one'. Is Io strongly typed or weakly typed? Support your answer with code.

    Io doesn't support implicit type conversion:

        Io> a := 1
        ==> 1
        Io> b := "1"
        ==> 1
        Io> a + b

        Exception: argument 0 to method '+' must be a Number, not a 'Sequence'
        ---------
        message '+' in 'Command Line' on line 1

    So it is a strongly typed language.

- Is 0 true or false? What about an empty string? Is nil true or false? Support your answer with code.

    0 is true
    
        Io> true and 0
        ==> true
    
    An empty string is true
    
        Io> true and ""
        ==> true
        
    nil is false
    
        Io> true and nil
        ==> false

- How can you tell what slots a prototype supports?

    By using the slotNames method
    
        Io> ObjectPrototype := Object clone
        ==>  ObjectPrototype_0x29d8a0:
          type             = "ObjectPrototype"

        Io> ObjectPrototype aslot := "a string"
        ==> a string
        Io> ObjectPrototype slotNames
        ==> list(aslot, type)

- What is the difference between = (equals), and := (colon equals), and ::= (colon colon equals)? When would you use each one?

        ::=	 Creates slot, creates setter, assigns value
        :=	 Creates slot, assigns value    
        =	 Assigns value to slot if it exists, otherwise raises exception

## Do: ##

- Run a program from a file

        $ Io afile.io

- Execute code in a slot given it's name

        object := Object clone
        object aslot := method("display this\n" print)
        object aslot