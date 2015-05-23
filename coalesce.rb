#! /usr/bin/env ruby

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
