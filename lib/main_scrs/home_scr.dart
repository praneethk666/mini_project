import 'package:flutter/material.dart';
import '../components/hoodie.dart';
import '../components/sidebar.dart';
import 'compos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: const Sidemenu(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              width: size.width,
              constraints: BoxConstraints(
                minHeight: size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const hoodie(),
                  const jumper(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            'MINI PROJECT',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
