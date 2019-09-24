def n_times(n)
    1.upto(n) { |number| yield(number) }



end

n_times 7 do |n|
    puts "#{n} situps"
    puts "#{n} pushups"
    puts "#{n} chinups"
end
