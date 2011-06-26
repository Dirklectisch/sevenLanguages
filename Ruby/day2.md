1. Print the contents of an array of sixteen numbers, four numbers at a time, using just each. 
        
        output = []

        (1..16).to_a.each do |n|
            output << n
            if n % 4 == 0
                p output
                output = []
            end    
        end
        
    Now do the same with each_slice in Enumerable.

        (1..16).to_a.each_slice(4) { |s| p s }
        
2. The Tree class was interesting, but it did not allow you to specify a new tree with a clean interface. Let the initializer accept a nested structure of hashes. You should be able to specify a tree like this: 

        options = 
            {'grandpa' => {
                'dad' => {
                    'child 1' => {}, 'child 2' => {}
                    },
                'uncle' => {
                    'child 3' => {}, 'child 4' => {}
                    }
                }
            }

    Answer:
        
        class Tree
          attr_accessor :children, :node_name

          def initialize(options)
            @node_name = options.first[0]
            @children = options.first[1].map do |child|
                    p Tree.new child[0] => child[1]
                end
          end

          def visit_all(&block)
            visit &block
            children.each {|c| c.visit_all &block}
          end

          def visit(&block)
            block.call self
          end
        end

        ruby_tree = Tree.new ({
            'Ruby' => {
                'Reia' => {},
                'MacRuby' => {}
            }
        })

        puts "Visiting a node"
        ruby_tree.visit {|node| puts node.node_name}
        puts

        puts "visiting entire tree"
        ruby_tree.visit_all {|node| puts node.node_name }

3. Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression match and read lines from a file.
        
        occ = 'a phrase'
    
        File.open('day2.md', 'r').each_line do |line|
            puts line if line.match(occ)
        end

 