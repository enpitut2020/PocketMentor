# Seeeeee:D 「PocketMentor」

## エレベータピッチ

**PocketMentor**は  
**いつかやりたいことが溜まること**を解決したい  
**ついついだらけちゃう人**向けの  
**モチベ支援アプリケーション**です。  
これは、**やりたいことに関連した記事を提案することで、やる気を回復させること**により、  
**TODOアプリ**とは違って  
**有意義な休日**を実現できます。  

## メンバー

- [katsuya](https://github.com/KindMaple)
- [basshi](https://github.com/Kurorie)
- [mei](https://github.com/mei28)
- [niwa](https://github.com/niwabarubossa)
- [nanaka](https://github.com/nanaka0012)
- [hotsukai](https://github.com/Hotsukai)

## 公開先

[公式Twitter Bot](https://twitter.com/MentorPocket)

## 今、何ができるの？

暇というキーワードを含んだキーワードをツイートすると、  
今まで登録したやりたいことに関する記事とあなたがやりたかったことがリプライされます！  
それによりユーザーは暇な時間をより良く使えます。

![4](https://user-images.githubusercontent.com/50493355/88658600-a66b0400-d10e-11ea-947b-70b6eafce628.png)

---

![twitter5](https://user-images.githubusercontent.com/50493355/88658595-a539d700-d10e-11ea-8b2f-8edf0de0873f.png)

## 開発環境

現在、進行中です！

- 環境構築はDockerを使っています。

## 動作方法

`.env`ファイルに各種環境変数を保存してください。

```bash
docker-compose build
docker-compose run test ruby main.rb
```

## リリースノート

### 7/29（水）

暇ツイートに多数のリプライが来てしまう不具合を修正しました。

**開発成果発表!!**

お疲れさまでした!!!!

### 7/28（火）

Firestore（データベース）と接続ができました。([sudame](https://github.com/sudame)さんへ圧倒的感謝...!!!)  
これにより、暇というキーワードを含んだキーワードをツイートすると、  
今まで登録したやりたいことに関する記事を再度リプライできるようになりました！

[28日での動作 その1](https://twitter.com/hotsu_create/status/1288048397069348865)  
[28日での動作 その2](https://twitter.com/hotsu_create/status/1288068251675590656)

### 7/27（月）

```Twitter
@MentorPocket
調べたいこと
```

とツイートすると**おすすめ記事**をリプライしてくれます！  
また、忘れた頃におすすめしてくれるように、データベースをセッティング中です!!  
[27日での動作](https://twitter.com/nanaka0012/status/1287656868546895872)

あらかじめやりたいことを本アカウントにメンションしておくと，「暇」ツイートをしたときに，やりたいことを検索した結果1位の記事がリプライで届きます!!

![twitter2](https://user-images.githubusercontent.com/50493355/88524283-1b1d4000-d034-11ea-9daa-aa8e6402ab6b.png)

### 7/24（金）

```Twitter
@MentorPocket
調べたいこと
```

とツイートすると**Googleで検索した結果**をリンクでリプライしてくれます！  
リンクを踏むだけで、結果をゲットできます！  

[24日での動作](https://twitter.com/hotsukai_mast/status/1286567105609863168)

開発チームの気が向いたときに、やりたいことの検索結果がリプライで届きます!!
![twitter](https://user-images.githubusercontent.com/50493355/88377808-ce8af800-cdda-11ea-8cf1-ec872f0c44e8.png)


### 7/23（木）

メンションを飛ばしてくれたら、**おうむ返し**をリプライでしてくれるようになりました！

[23日での動作](https://twitter.com/hotsukai_mast/status/1286479605306503168)
