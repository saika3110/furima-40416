class Genre < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: 'メンズ' },
   { id: 3, name: 'レディース' },
   { id: 4, name: 'ベビー・キッズ' },
   { id: 5, name: 'インテリア・住まい・小物' },
   { id: 6, name: '本・音楽・ゲーム' },
   { id: 7, name: 'おもちゃ・ホビー・グッズ' },
   { id: 8, name: '家電・スマホ・カメラ' },
   { id: 9, name: 'スポーツ・レジャー' },
   { id: 10, name: 'ハンドメイド' }
   { id: 11, name: 'その他' }
 ]

 end

 <%#
  <select class="genre-select" name="article[genre_id]" id="article_genre_id">
  <option value="1">---</option>
  <option value="2">経済</option>
  <option value="3">政治</option>
  <option value="4">地域</option>
  <option value="5">国際</option>
  <option value="6">IT</option>
  <option value="7">エンタメ</option>
  <option value="8">スポーツ</option>
  <option value="9">グルメ</option>
  <option value="10">その他</option>
</select>
%>