import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Item> _items = [];
  
  @override
  void initState() {
    // 원하는 목록 길이를 넣어주세요!
    _setItems(20);
    super.initState();
  }

  /// 파라미터([length])에 원하는 길이를 입력해주세요
  void _setItems(int length) {
    // 정해진 개수만큼 리스트 생성
    List<Item> madeList = List.generate(length, (index) => Item());
    // 아이템에 추가
    _items.addAll(madeList);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본 리스트뷰 연습'),
      ),
      // 해당 위젯은 0부터 정해진 길이 (아래의 itemCount) 까지 증가하면서
      // 각 인덱스에 해당하는 위젯을 반환한다.
      body: ListView.builder(
        // 아이템을 만들어 주는 함수.\
        // 첫번째 인자는 BuildContext,
        // 두번째 인자는 인덱스
        itemBuilder: (BuildContext context, int index){
          // 아이템으로 위젯을 만드는 함수를 통해서 위젯을 만든다
          return buildItemList(index);
        },
        // 길이는 목록의 길이
        itemCount: _items.length,
      ),
    );
  }

  /// 아이템별로 맞는 위젯을 생성하는 함수. [item]은 위젯을 만들때 사용할 데이터
  Widget buildItemList(int index) {
    // 인덱스에 해당하는 아이템 찾고
    Item item = _items[index];

    // 찾은 아이템으로 리스트 아이템 생성
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.black12,
          blurRadius: 3,
          offset: Offset(3, 3),
        )],
      ),
      // 여기서 부터가 콘텐츠
      child: Row(
        children: [
          // 그냥 신발 이미지
          // ClipRRect 는 외곽 곡선으로 내용물을 잘라주는 위젯
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
            // 실제 이미지 표시하는 위젯
            child: Image.network(
              item.itemPath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // 이름 표시
          // Expanded 는 Column 이나 Row 안에서 나머지 영역 다먹는거 Flex 혼자쓰는거랑 동일
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(item.name),
            ),
          ),

          // 하트 버튼 InkWell 은 터치를 인식하는 위젯입니다
          InkWell(
            // 터치되면 불리는 함수. 여기서 값을 바꿔줄거에요
            onTap: (){
              // setState 함수의 파라미터로 전달되는 함수가 종료되면 화면이 다시 그려져요
              setState(() {
                // 여기서 가지고 있는 _item의 아이템을 변경해주고
                // 화면을 다시 그리는 작업
                _items[index].isLiked = !_items[index].isLiked;
              });
            },
            // 터치영역을 위해 패딩 주려고 container 로 감싸고
            child: Container(
              padding: EdgeInsets.all(8),
              // 실제 하트 아이콘
              child: Icon(
                // 좋아요가 되면 채워진 하트, 아니면 빈하트 삼항연산자 공부필요
                item.isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),

        ],
      ),
    );
  }
}


class Item {
  // 인터넷에 있는 아무 신발 사진 주소입니다
  String itemPath = 'https://assets.ajio.com/medias/sys_master/root/hd4/h99/14092964397086/-1117Wx1400H-460455972-black-MODEL.jpg';
  // 표시할 신발 이름
  String name = '리스트 연습용 신발 이름';
  // 하트 여부
  bool isLiked = false;
}