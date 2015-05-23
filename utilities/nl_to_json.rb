#!/usr/bin/env ruby
require 'json'
require 'open-uri'
require 'nokogiri'

filename = ARGV[0]

symbols = Array.new
f = File.open(filename, "r")
f.each_line do |line| 
	symbols.push(line.gsub("\n", ''))
end
f.close

data = Array.new
symbols.each do |symbol| 
	url = "http://dev.markitondemand.com/Api/v2/Quote?symbol=" + symbol
	response = Nokogiri::XML(open(url))
	# puts response
	if (response.at_xpath("//StockQuote"))
		
		volume = response.at_xpath("//Volume").content
		change = response.at_xpath("//Change").content
		changepercent = response.at_xpath("//ChangePercent").content
		lastprice = response.at_xpath("//LastPrice").content

		stock = Hash.new
		stock["Symbol"] = symbol
		stock["Volume"] = volume
		stock["Change"] = change
		stock["ChangePercent"] = changepercent
		stock["LastPrice"] = lastprice

		puts stock

		data.push(stock)
	end

end


