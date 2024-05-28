#!/usr/bin/env ruby

def fizzbuzz(n)
    return nil if n.class != Integer || n < 1

    if n % 15 == 0
        "FizzBuzz"
    elsif n % 3 == 0
        "Fizz"
    elsif n % 5 == 0
        "Buzz"
    else
        n
    end
end

(1..20).each do |i|
    puts fizzbuzz(i)
end
