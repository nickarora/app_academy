 'zero'
 'one'
 'two'
 'three'
 'four'
 'five'
 'six'
 'seven'
 'eight'
 'nine'



 'ten'
 'eleven'
 'twelve'


 'thirteen'
 'fourteen'
 'fifteen'
  16.in_words.should == 'sixteen'
  17.in_words.should == 'seventeen'
  18.in_words.should == 'eighteen'
  19.in_words.should == 'nineteen'
end

it "reads tens" do
  20.in_words.should == 'twenty'
  30.in_words.should == 'thirty'
  40.in_words.should == 'forty'
  50.in_words.should == 'fifty'
  60.in_words.should == 'sixty'
  70.in_words.should == 'seventy'
  80.in_words.should == 'eighty'
  90.in_words.should == 'ninety'
