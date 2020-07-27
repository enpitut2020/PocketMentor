# !/usr/bin/env ruby
require 'google/apis/customsearch_v1'
require 'json'
require "dotenv"

Dotenv.load
API_KEY=ENV['GOOGLE_API_KEY']
CSE_ID=ENV['SEARCH_ENGINE_ID']#カスタムサーチAPI

custom_search_api = Google::Apis::CustomsearchV1::CustomsearchService.new
custom_search_api.key = API_KEY

query = {
  num: 3,
  start: 1,
  cr: 25,
  cx: CSE_ID
}

json = custom_search_api.list_cses("ビーフストロガノフ",query).to_json

puts json