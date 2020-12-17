import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sanpham.dart';
import 'fakedata.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<bool> checked = [true, true, false, false, true];

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();

    Map<int, Widget> _children = {
      0: Text(
        'Báo giá',
        style: TextStyle(color: Colors.white),
      ),
      1: Text('Đơn hàng', style: TextStyle(color: Colors.white)),
    };

    List<int> _disabledIndices = [];
    List<SanPham> sanphams = FAKE_SANPHAM.toList();

    final formatter = new NumberFormat("#,###");
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            CircleAvatar(
              backgroundColor: Colors.amber[900],
              child: IconButton(
                  color: Colors.white, icon: Icon(Icons.add), onPressed: () {}),
            ),
          ],
          title: Text(
            'Yêu cầu của tôi',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 48),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MaterialSegmentedControl(
                      children: _children,
                      borderColor: Colors.amber[900],
                      selectedColor: Colors.yellow[900],
                      unselectedColor: Colors.yellow[900],
                      borderRadius: 8.0,
                      disabledChildren: _disabledIndices,
                      onSegmentChosen: (index) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Center(
            child: ListView.builder(
                itemCount: sanphams.length,
                itemBuilder: (context, index) {
                  SanPham sanPham = sanphams[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    color: Colors.yellow[900],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Yêu cầu trực tiếp',
                                    style: TextStyle(
                                        color: Colors.yellow[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(DateFormat('hh:mm dd/MM/yyyy').format(now)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hết hạn báo giá sau:',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'báo giá\t',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('xem\t',
                                      style: TextStyle(color: Colors.grey)),
                                  Text('chọn',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                           ClipRRect(
                              child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                  placeholder: 'assets/images/loading.gif',
                                  image: sanPham.urlImage),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(formatter.format(sanPham.donGia)+' đ\t'),
                                Icon(Icons.remove_red_eye),
                                Icon(Icons.check_box_outline_blank),
                                Icon(Icons.warning,),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Hủy yêu cầu',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[400],
                          thickness: 3,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Dịch vụ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Ghi chú',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 15,
          selectedItemColor: Colors.yellow[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
