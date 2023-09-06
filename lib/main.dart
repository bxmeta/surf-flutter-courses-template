import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyVisitingCard(),
    );
  }
}

class MyVisitingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Моя визитка'),
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            children: [
              // Фотография
              Container(
                margin: const EdgeInsets.all(20),
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // ФИО
              const Text(
                'ФИО',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubikiso'
                ),
              ),

              // Раздел "О себе"
              const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                title: Text('О себе'),
                subtitle: Text('Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне'),
              ),

              // Раздел "Увлечения"
              ListTile(
                leading:  SvgPicture.asset(
                  'icons/heart-svgrepo-com.svg',
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                ),
                title: Text('Увлечения'),
                subtitle: Text('Давно выяснено, что при оценке дизайна и композиции читаемый текст мешает сосредоточиться.'),
              ),

              // Раздел "Опыт в разработке"
              const ListTile(
                leading: Icon(
                  Icons.code,
                  size: 30,
                ),
                title: Text('Опыт в разработке'),
                subtitle: Text('Программирую так, что даже кофеварка у меня на Android.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
