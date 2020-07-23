# Pocket Mentor


## タグコメント 

YARDにおけるタグコメントに準拠して書いていく．

```ruby
#
# ユーザの操作を行うクラス
#
class User

  #
  # ユーザを作成
  # @param [String] name ユーザ名
  # @param [String] password パスワード
  #
  def initialize(name, password)
    @name     = name
    @password = password
  end

  #
  # メールアドレスを取得
  # メールアドレスはユーザ名を元に決定する
  # @return [String] ユーザごとのメールアドレス
  #
  def email
    "#{@name}@#{email_domain}"
  end

  #
  # システムにログインする
  # @param  [String] password ログイン用パスワード
  # @return [True]  ログイン成功
  # @return [False] ログイン失敗
  #
  def login(password)
    return password === @password
  end

  private
    #
    # メールアドレス用のドメインを取得
    # @return [String] ドメイン
    #
    def email_domain
      "gmail.com"
    end

end
```

## コミットメッセージ

`UPDATE：機能修正（バグではない`  
`ADD：新規（ファイル）機能追加`  
`FIX：バグ修正`  
`REMOVE：削除（ファイル)`  


## ブランチ名