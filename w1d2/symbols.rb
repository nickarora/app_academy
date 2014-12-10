def super_print(string, options = {})
  defaults = {:times => 1,
              :upcase => false,
              :reverse => false
              }

  options = defaults.merge(options)

  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]

  options[:times].times do
    puts  string
  end

end

if __FILE__ == $0
  super_print("Hello")                                    #=> "Hello"
  super_print("Hello", :times => 3)                       #=> "Hello" 3x
  super_print("Hello", :upcase => true)                   #=> "HELLO"
  super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH
end