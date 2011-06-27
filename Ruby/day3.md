Modify the CSV application to support an each method to return a CsvRow object. Use method_missing on that CsvRow to return the value for the column for a given heading.

For example the file:

        one, two
        lions, tigers
    
allow an API that works like this:

        csv = RubyCsv.new
        csv.each { |row| puts row.one }
        
This should print "lions".

---

        module ActsAsCsv
  
          def self.included(base)
            base.extend ClassMethods
          end
  
          module ClassMethods
            def acts_as_csv
              include InstanceMethods
            end
          end
  
          class CsvRow
     
             attr_reader :headers, :values
     
             def initialize headers, values
                @headers = headers
                @values = values 
             end
     
             def method_missing name, *args
                 idx = self.headers.find_index(name.to_s)
                 return values[idx]
             end
      
          end
  
          module InstanceMethods
    
            def read
              @csv_contents = []
              filename = self.class.to_s.downcase + '.txt'
              file = File.open(filename, 'r')
              @headers = file.gets.chomp.split(', ')

              file.each do |row|
                @csv_contents << row.chomp.split(', ')
              end
            end
    
            def each
                self.csv_contents.each do |row|
                    yield CsvRow.new self.headers, row
                end
            end
    
            attr_accessor :headers, :csv_contents
    
            def initialize
              read 
            end

          end

        end

        class RubyCsv  # no inheritance! You can mix it in
          include ActsAsCsv
          acts_as_csv
        end

        csv = RubyCsv.new
        csv.each { |row| puts row.one }


