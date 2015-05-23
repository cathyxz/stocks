#! /usr/bin/env ruby

require 'open-uri'

symbols = Array.new
f = File.open("nasdaq_tickers.txt", "r")
f.each_line do |line| 
	symbols.push(line.gsub("\n", ''))
end
f.close

symbols.each do |s|
  filename = s + '.csv'
  path = 'data/' + filename
  open(path, 'wb') do |file|
    file << open('http://ichart.yahoo.com/table.csv?s='+s).read
  end
end

