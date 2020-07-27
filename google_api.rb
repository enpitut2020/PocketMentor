# !/usr/bin/env ruby
require 'google/apis/customsearch_v1'
require 'json'
require "dotenv"
Dotenv.load

# Google Custom Search のクラス
class MyGoogleCustomSearcher
  # コンストラクタ
  def initialize()
    @API_KEY = ENV['GOOGLE_API_KEY']
    @CSE_ID = ENV['SEARCH_ENGINE_ID']#カスタムサーチAPI

    @searcher = Google::Apis::CustomsearchV1::CustomsearchService.new
    @searcher.key = @API_KEY
  end
  
  # 検索した結果のjsonをhashに変換する
  # @param [String] 検索する単語
  # @param [Integer] 検索件数
  # @param [Boolean] ファイルに出力するかどうか
  # @return [hash] 検索結果のハッシュ
  def search(phrase="プリン", num=3, output=false)
    query = {
      num: num,
      start: 1,
      cr: 25,
      cx: @CSE_ID
    }
    json = @searcher.list_cses(phrase, query).to_json
    hash = JSON.parse(json)
    # puts json
    if output
      File.open("search_json/result_#{phrase}.json", 'w') do |file|
        str = JSON.dump(hash, file)
      end
    end
    return hash
  end

end

