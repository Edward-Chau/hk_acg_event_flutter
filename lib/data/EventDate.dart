import 'dart:convert';

import 'package:hk_acg_event_information/data/apiClient.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/model/enumCategory.dart';
import 'package:http/http.dart' as http;

class ProvideData {
  static Future<List<Event>> getEventList() async {
    // var url = Uri.http(Apiclient.api, 'events'); // 確保路徑正確
    // print(url);

    try {
      var url = Uri.http(Apiclient.api, 'events'); // 確保路徑正確

      var response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          List<dynamic> jsonList = jsonDecode(response.body);

          List<Event> returnList = [];
          for (int i = 0; i < jsonList.length; i++) {
            final EvenCategory evenCategory = EvenCategory.values.firstWhere(
              (cat) => cat.name == jsonList[i]['evenCategory'],
              orElse: () => EvenCategory.acg,
            );

            List<String> imageList = [];
            for (int j = 0; j < jsonList[i]['eventImages'].length; j++) {
              imageList.add(jsonList[i]['eventImages'][j]['imageUrl']);
            }
            print(jsonList[i]['officialURL'] ?? '');
            final Event getEvent = Event(
              id: jsonList[i]['eventId'] ?? -1,
              imageURL: imageList, // jsonList[i]['eventImages'] ?? '',
              title: jsonList[i]['title'] ?? 'N/A',
              date: [DateTime.now()],
              ticket: (jsonList[i]['ticket'] as int).toDouble(),
              amount: ['amount'],
              evenCategory: evenCategory,
              organizer: jsonList[i]['organizer'] ?? 'N/A',
              officialURL: jsonList[i]['officialURL'] ?? 'N/A',
              location: jsonList[i]['location'] ?? 'N/A',
              eventDetail: jsonList[i]['eventDetail'] ?? '沒有資訊',
            );

            returnList.add(getEvent);
          }
          // return [];
          return returnList;
        } else {
          throw Exception('API 錯誤，狀態碼：${response.statusCode}');
        }
      }
    } catch (e) {
      throw Exception('獲取活動列表時發生錯誤: $e');
    }

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    return [
      // for (int i = 0; i < 10; i++)
      //   Event(
      //     id: 1,
      //     imageURL: 'https://i.ibb.co/Zgzmjdq/fbthumb.jpg',
      //     title: 'Palette Ring 8 綜合同人展',
      //     date: [
      //       DateTime(2024, 10, 26, 19),
      //       DateTime(2024, 10, 27, 19),
      //     ],
      //     ticket: '45',
      //     amount: [
      //       '預售門票發售：10月10日開始',
      //       '票價：\$45/日（預售門票至10月25日）',
      //       '每次交易可購入其中一天最多4張門票',
      //     ],
      //     evenCategory: EvenCategory.comicMarket,
      //     organizer: 'Palette Ring 綜合同人展委員會',
      //     officialURL: 'https://www.palette-ring.com/',
      //     location: '麥花臣場館 (九龍旺角奶路臣街 38 號)',
      //     eventDetail: 'hello',
      //   )
    ];
  }
}

// final List<Event> registeredEvent = [
  // Event(
  //   id: 1,
  //   imageURL: 'https://i.ibb.co/Zgzmjdq/fbthumb.jpg',
  //   title: 'Palette Ring 8 綜合同人展',
  //   dateStart: [
  //     DateTime(2024, 10, 26, 12),
  //     DateTime(2024, 10, 27, 12),
  //   ],
  //   dateEnd: [
  //     DateTime(2024, 10, 26, 19),
  //     DateTime(2024, 10, 27, 19),
  //   ],
  //   ticket: '45',
  //   amount: [
  //     '預售門票發售：10月10日開始',
  //     '票價：\$45/日（預售門票至10月25日）',
  //     '每次交易可購入其中一天最多4張門票',
  //   ],
  //   evenCategory: EvenCategory.comicMarket,
  //   organizer: 'Palette Ring 綜合同人展委員會',
  //   officialURL: 'https://www.palette-ring.com/',
  //   location: '麥花臣場館 (九龍旺角奶路臣街 38 號)',
  //   information: [
  //     '《 Palette Ring 8 綜合同人展》',
  //     '當日離場後可以憑手印再次入場',
  //     '(當日入場人士可獲取場刊一本，派完即止)',
  //     'Btw輕輕一提，PR8星期六日約定你!'
  //   ],
  // ),
  // Event(
  //   imageURL: 'https://i.ibb.co/tb9mg59/images.jpg',
  //   title: 'Pure Love 5 紅葉祭 •綜合同人祭',
  //   dateStart: [
  //     DateTime(2024, 11, 9, 11),
  //     DateTime(2024, 11, 10, 11),
  //   ],
  //   dateEnd: [
  //     DateTime(2024, 11, 9, 19),
  //     DateTime(2024, 11, 10, 19),
  //   ],
  //   ticket: '60',
  //   amount: [
  //     'HKD60 (標準)',
  //     'HKD80 (快速)',
  //     'HKD120 (VIP)',
  //   ],
  //   evenCategory: EvenCategory.acg,
  //   organizer: '始源Shigen. Pure Love 綜合同人祭',
  //   officialURL: 'https://purelove.hk/',
  //   location: 'D2 Place （MTR荔枝角站D2出口）',
  //   information: [
  //     '【Pure Love 5 紅葉祭🍁 活動資訊】',
  //     '第5屆Pure Love 綜合同人祭 將會在11月9、10日於 D2 Place 舉行！',
  //     '是次活動每日將有超過300個同人及商業攤位參與。活動内容包括「同人誌即賣會」、「舞台表演」及「角色扮演」！大家有興趣記得前來支持他們❤'
  //   ],
  // ),
  // Event(
  //   imageURL: 'https://i.ibb.co/Y3bH2ww/jump-only-hk.png',
  //   title: 'Jump Only HK',
  //   dateStart: [DateTime(2024, 11, 17, 12, 30)],
  //   dateEnd: [DateTime(2024, 11, 17, 19)],
  //   ticket: '50',
  //   amount: [
  //     'VIP門票🎟️',
  //     '售價：\$100',
  //     '每人限買2張',
  //     '入場時間：12:00 pm 優先入場，無需等候',
  //     '',
  //     '普通門票',
  //     '售價：\$50',
  //     '每人限買6張',
  //     '入場時間：12:30 pm 後- 按現場時間籌而定',
  //   ],
  //   evenCategory: EvenCategory.only,
  //   organizer: 'Jump Only HK',
  //   officialURL: 'https://jumponlyhongkong.weebly.com/',
  //   location: '九龍觀塘興業街4號The Wave 8樓',
  //   information: [
  //     '《Jump Only HK》活動將於2024年11月17日 (週日) 舉辦🎉',
  //     '活動內容包括同人攤位、表演區、及互動遊戲。',
  //     '',
  //     '相信大家總有一部Jump作品陪伴成長，',
  //     '作品中的熱情、友情、努力、勝利，令人深深感動。',
  //     '順應著時代轉變，不論新舊作品都值得回味！',
  //     '希望熱愛Jump 的大家能踴躍支持活動！',
  //   ],
  // ),
  // Event(
  //   imageURL: 'https://i.ibb.co/JpT6rT7/image.png',
  //   title: '【霜月式•界雷】- 綜合同人祭2024 ',
  //   dateStart: [DateTime(2024, 11, 24, 11)],
  //   dateEnd: [DateTime(2024, 11, 24, 19)],
  //   ticket: ' N/A',
  //   amount: ['N/A'],
  //   evenCategory: EvenCategory.comicMarket,
  //   organizer: '香港大學動漫聯盟 ACA, HKU',
  //   officialURL:
  //       'https://linktr.ee/acahku?fbclid=PAZXh0bgNhZW0CMTEAAaZNRlsMrqY_etsGS4YIcAoRTv8ma4lF9cyydIf3IFk5IaDtCCv46cJkixU_aem_y7MT_g__on1bjRtRBbkFdQ',
  //   location: '發現號 03（觀塘海濱道86號）',
  //   information: [
  //     '這是香港大學動漫聯盟的第十三屆霜月式，亦是第一次動漫聯盟離開了香港大學而在外舉辦的霜月式。',
  //     '',
  //     '說起「界雷」這個名字，其實出自於一個天氣現象。複雜難言，卻很能代表我們這一路以來的心路歷程，及對此次霜月式的盼望。',
  //     '',
  //     '自從上年未能舉辦霜月式後，我們一直在尋找新的機遇。從二月到六月，「遙」不止與校方繼續協商，亦諮詢了不少外部場地作爲備選方案。香港大學對一直以來支持霜月式的你們，及我們都具有非凡的意義，我們很希望能夠在這裏與各位共筆續寫霜月式的故事。只是很遺憾，由於各種考慮，活動未能再次在香港大學舉辦。此時此刻，「遙」便轉眼於另一重要之事，霜月式當下的延續 – 觀塘發現號的嘗試。',
  //     '',
  //     '常說物是人非，「遙」相信著就算物亦無法留下，只要「霜月式」一日存在，我們那共同的盼望，當中屬於各位的一點一滴，就不會改變。霜月式一路以來有着你們的參與，才得以取得多次成功。',
  //     '',
  //     '現誠邀各位蒞臨第十三屆《霜月式 • 界雷》，與我們一同再度出發，留下美好回憶。無論多麼遙遠，亦能一賞這界雷爲我們所帶來的變化。',
  //     '',
  //     '— 遙，香港大學動漫聯盟第二十七屆幹事會',
  //     '',
  //     '',
  //     '*本活動由於外在不確定因素，有可能在宣告舉辦後取消或改期，本會對活動舉辦與否擁有最終決定權。詳情將於稍後公佈。',
  //   ],
  // ),
  // Event(
  //   imageURL: 'https://i.ibb.co/0DdBw4D/image.png',
  //   title: 'Unlight Only 2024',
  //   dateStart: [DateTime(2024, 8, 12)],
  //   dateEnd: [DateTime(2024, 8, 12)],
  //   ticket: '55',
  //   amount: [
  //     '一般入場門票預售價錢為HKD\$55',
  //     '活動當天價錢為HKD\$60。',
  //   ],
  //   evenCategory: EvenCategory.only,
  //   organizer: 'ULOHK2024',
  //   officialURL: 'https://www.instagram.com/fofd.30y/',
  //   location: '新蒲崗六合街21號Artisan Lab7樓',
  //   information: [
  //     '我們已經悄悄地替FOFD的SNS換了新衣了喔(´▽`ʃ♡ƪ)"',
  //     '趁著今年Unlight重新開放官方伺服器',
  //     '來跟著FOFD一起回到在星幽界出任務的日子吧！',
  //   ],
  // ),
  // Event(
  //   imageURL: 'https://i.ibb.co/c3Z9BpP/image.png',
  //   title: 'RIP ONLY',
  //   dateStart: [DateTime(2024, 12, 19, 11, 30)],
  //   dateEnd: [DateTime(2024, 12, 19, 18, 30)],
  //   ticket: '88',
  //   amount: [
  //     'COSER的門票價格為88元',
  //     'VIP的門票價格為100HKD一張',
  //   ],
  //   evenCategory: EvenCategory.only,
  //   organizer: 'rip_onlyhk',
  //   officialURL: 'https://www.instagram.com/rip_onlyhk/',
  //   location: '九龍新蒲崗六合街21號Artisan Lab七樓',
  //   information: [
  //     'RIP ONLY以所有作品中已死亡的角色為主題的同人誌販售交流會。',
  //     '將於2024年12月29日舉行活動',
  //     '活動將保留祭壇區域，祭品由參加者自行決定，大會將不予提供，',
  //     '但禁止放置香燭火蠟衣紙相關，僅限角色相關物品或糖果，夜神月和地獄少女會繼續保留在入場程序上。',
  //   ],
  // ),
  // Event(
  //   imageURL:
  //       'https://static.wixstatic.com/media/f981c1_d5d1a5044c1944218c2f652c4a8ab26e~mv2.jpg/v1/fill/w_560,h_314,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/ACGxEDN_Klook%20banner_2048x1152px_V1.jpg',
  //   title: 'Z+ ACG X EDM Hong Hong 2025',
  //   dateStart: [DateTime(2025, 1, 11),DateTime(2025, 1, 12)],
  //   dateEnd: [DateTime(2025, 1, 11),DateTime(2025, 1, 12)],
  //   ticket: '50',
  //   amount: [
  //     '12歲以下兒童免費入場',
  //     '\$50［展覽門票（動漫市集及遊戲體驗區）］',
  //     '\$488 ［白金日間通行證 （門票已包括白金日間通行證、展覽門票及飲品乙份）］',
  //     '\$688 ［VIP日間通行證 （門票已包括VIP日間通行證、展覽門票及小食和飲品各乙份）］',
  //   ],
  //   evenCategory: EvenCategory.electronicMusic,
  //   organizer: 'Event Plus Design & Production Limited',
  //   officialURL:
  //       'https://www.zplus.com.hk/?fbclid=PAZXh0bgNhZW0CMTEAAaacHmHuYSCQ41CdspGufpafxYjv7C7eTWdzB54cPygNSFbUM8Pjo9jR_Bw_aem_WH1x7APQmoZhqWD__EoiEw',
  //   location: '安盛 x 竹翠公園 (西九)',
  //   information: [
  //     '2024年未玩夠？等Z plus 為大家plan定 2025年第一個節目喇！Z Plus 將在2025年1月11至12日於安盛 x 竹翠公園 (西九)向大家隆重呈獻全港首個ACG crossover 電音的大型活動 （Z Plus ACGxEDM HK 2025 動漫電音節）！屆時，將邀請多名來自日本、韓國及台灣熱門DJ電音表演，當中包括有DJ Mao、DJ Amber、台灣黑澀會初代成員 - DJ Swallow_嬌、前Kpop 女團成員 - Rana 及來自韓國的DJ Milky等等，更有流行的日系地下偶像團隊和著名Cosplayer為大家帶來青春和流行元素的現場表演，體驗到秋葉原的偶像魅力！現場更有多個遊戲體驗及豐富禮品，保證令你目不暇給！'
  // ],
  // ),
// ];
