# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Game.count.zero?
  Game.create(title: "海龜湯（經典）" , description: "一位船長喝了一碗湯，覺得味道怪怪的，他問起店家這是什麼湯，店家告訴他這是海龜肉做成的湯，船長便沉思了一會兒......痛哭了起來，自殺了。為什麼？", whole_story: "船長以前出海的時候，因為遇上暴風雨船隻故障在海上漂泊了許久，大家都沒東西吃，有些船員甚至因為暴風雨而過世了，於是有船員為了讓船長活下去，將已經去世的船員的肉煮成湯給船長喝，騙他說是海龜肉，結果船長就活下來了。多年後船長吃到了真正的海龜肉，終於明白當時發生了什麼事情，傷心之下選擇自殺。")

  Game.create(title: "牛吃草" , description: "有一個年輕的男人，他的房子和鄰居夫婦的房子中間隔著一片草坪。有一天深夜，男人被隔壁的吵架聲吵醒，之後他又聽到了摔東西聲、砍刀子聲和牛吃草的聲音，過了一會，他又聽到了有人撞他家門的聲音，但他都沒有理會，又睡了過去。第二天，他發現隔壁的女主人慘死在他家門口。", whole_story: "夫妻吵架,丈夫用斧頭砍斷妻子4肢，然後妻子用口咬著地上的草爬行~爬到年輕男人家門口用頭嗑門求救！最後自然是失血過多死了。")

  Game.create(title: "水草" , description: "有個男子跟他女友去湖邊散步，突然他的女友掉進湖裏了，那個男子就急忙跳到水裏去找，可沒找到他的女友，他傷心的離開了這裏。過了幾年後，他故地重遊，這時看到有個老人家在釣魚，可那老人家釣上來的魚身上沒有水草，他就問那老人家為什?魚身上沒有沾到一點水草，那老人家說：“你不知道啊，這湖從沒有長過水草。”說到這時那男子突然跳到水裏，自殺了，為什麼？", whole_story: "因為當時男子跳下去湖裡時，手有摸到類似水草的觸感，而那個觸感是他女友的頭髮，如果當時有確認是不是他女友的話說不定就能挽救女友的性命。")

  Game.create(title: "葬禮姐妹" , description: "有母女三人，母親死了，姐妹倆去參加葬禮，妹妹在葬禮上遇見了一個很帥氣的男子，並對他一見傾心。但是葬禮後那個男子就不見了，妹妹怎麼找也找不到他。後來過了一個月，妹妹把姐姐殺了，為什麼？", whole_story: "因為妹妹想再開一次葬禮，再次見到那個帥氣男子")
  
  Game.create(title: "人聲" , description: "隔壁房間裡傳來許多人的聲音，時而騷動不安，時而歡笑不已，但當你趕緊跑到隔壁房間打開門時，卻發現房間裡只有一個人，請問這些聲音是從哪裡來的？", whole_story: "其實是隔壁的人正在看電視節目。")
  
end
