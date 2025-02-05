import 'package:flutter/material.dart';
import 'package:mofu_flutter/data/list.dart';
import 'package:mofu_flutter/ui/view/home_view/home_page.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  void _showButtonPressDialog(BuildContext context, String provider) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: const Duration(milliseconds: 400),
      
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Expanded(
              child: Center(
                  child: Image(
            image: const AssetImage('assets/images/logo/logo.png'),
            height: displayHeight * 0.25,
          ))),
          Expanded(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 1.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(padding: EdgeInsets.only(bottom: 50)),
          Container(
            child: Text('3초만에 빠른 로그인!',
                style: TextStyle(fontSize: 15, color: Color(0xffFFBA7D))),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Container(
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                _showButtonPressDialog(context, 'Google');
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 50))
        ],
      )),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFBA7D),
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}

final List<String> imgList = [
  'assets/images/banners/display_01.png',
  'assets/images/banners/display_02.png',
  'assets/images/banners/display_03.png'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(1.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.fitHeight, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();
