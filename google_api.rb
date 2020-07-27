#!/usr/bin/env ruby
require 'google/apis/customsearch_v1'
require "dotenv"

Dotenv.load
API_KEY=ENV['GOOGLE_API_KEY']
CSE_ID=ENV['SEARCH_ENGINE_ID']#カスタムサーチAPI



searcher = Google::Apis::CustomsearchV1::CustomsearchService.new
searcher.key = API_KEY

print "検索したい文字列> "
query = gets.chomp

results = searcher.list_cses(query, {cx: CSE_ID})
items = results.items
pp items.map {|item| { title: item.title, link: item.link} }
