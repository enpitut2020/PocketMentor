require 'json'

filename='search_json/result_pudding.json'
File.open(filename) do |file|
    hash=JSON.load(file)
    hash["items"].each do |item|
        puts "title : #{item["title"]}\n" 
        puts "URL : #{item["htmlFormattedUrl"]}"
        puts "ImagesURL : #{item["pagemap"]["cse_image"][0]["src"]}\n"
    end
end
