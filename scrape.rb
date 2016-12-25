#! /usr/bin/env ruby

require 'open-uri'


symbols = Array.new
f = File.open("nasdaq_tickers.txt", "r")
f.each_line do |line| 
	symbols.push(line.gsub("\n", ''))
end
f.close

symbols.each do |s|
  begin
      filename = s + '.csv'
      path = 'data/' + filename
      open(path, 'wb') do |file|
        file << open('http://ichart.yahoo.com/table.csv?s='+s).read
      end
  rescue => e
      case e
      when OpenURI::HTTPError
          puts "Ticker " + s + " not found."
          File.delete(path)
      end
  end
end

open('master.csv', 'wb') do |master|

  Dir.glob('data/*.csv') do |filename|
    file = File.open(filename)
    ticker = filename.gsub('data/', '').gsub('.csv', '')
    file.each_with_index do |line, index|
      next if index == 0
      master.puts ticker + ',' + line
    end
    file.close
  end

end

