import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nako2/providers/dashboard_providers.dart';
import 'package:nako2/views/berita_panel.dart';
import 'package:nako2/views/peta_view.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final panels = [DashboardPanel(), BeritaPanel(), SizedBox()];

    return Consumer<DashboardProvider>(builder: (Context, Provider, Widget) {
      return Scaffold(
          bottomNavigationBar: NavigatorBawah(),
          body: panels[Provider.indexTombol]);
    });
  }
}

class NavigatorBawah extends StatelessWidget {
  const NavigatorBawah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = context.read<DashboardProvider>();

    return BottomNavigationBar(
      currentIndex: p.indexTombol,
      onTap: (value) {
        p.saatdiklik(value);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: 'Beranda'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.newspaper), label: 'Berita'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wrench), label: 'Pengaturan'),
      ],
    );
  }
}

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BackgroundDashboard(),
        _InfoPengguna(),
        Card(
          elevation: 0,
          margin: EdgeInsets.fromLTRB(0, 180, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Berita',
                    style: TextStyle(fontSize: 20),
                  ),
                  _ListBerita(),
                  SizedBox(
                    height: 20,
                  ),
                  _ListIcon(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ListIcon extends StatelessWidget {
  const _ListIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _TombolMenu(
          gambar: 'assets/icon1.png',
        ),
        _TombolMenu(
          gambar: 'assets/icon2.png',
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, 
              MaterialPageRoute(builder: (c)=>PetaView() ));
          },
          child: _TombolMenu(
            gambar: 'assets/icon3.png',
          ),
        ),
        _TombolMenu(
          gambar: 'assets/icon4.png',
        ),
      ],
    );
  }
}

class _TombolMenu extends StatelessWidget {
  final String gambar;
  const _TombolMenu({Key? key, this.gambar = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9), //Disini ubah jarak dan tampilan
      margin: EdgeInsets.all(8),
      child: Image.asset(
        gambar,
        width: 60,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 96, 92, 114), //Monggo Dicostum warnanya
          boxShadow: [
            BoxShadow(
                color:
                    Color.fromARGB(255, 12, 6, 97), //Monggo Dicostum warnanya
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2, 2))
          ]),
    );
  }
}

class _ListBerita extends StatelessWidget {
  const _ListBerita({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 175,
      child: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _ItemBerita(
              assetsgambar: 'assets/berita1.jpg',
            ),
            _ItemBerita(
              assetsgambar: 'assets/berita2.jpg',
            ),
            _ItemBerita(
              assetsgambar: 'assets/berita3.jpg',
            ),
            _ItemBerita(
              assetsgambar: 'assets/berita4.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemBerita extends StatelessWidget {
  final String assetsgambar;
  const _ItemBerita({Key? key, this.assetsgambar = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          assetsgambar,
          width: 250,
          height: 130,
        ),
      ),
    );
  }
}

class _InfoPengguna extends StatelessWidget {
  const _InfoPengguna({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 60, 22, 0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/foto.jpg',
              height: 60,
              width: 60,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hi, Nako',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  'Naffiilham@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          Image.asset(
            'assets/bell.png',
            width: 30,
          )
        ],
      ),
    );
  }
}

class _BackgroundDashboard extends StatelessWidget {
  const _BackgroundDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/background.jpg',
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

//////////////////////////////////CODE PERCOBAAN SENDIRI /////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DashboardView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigatorBawah(),

//       body: Stack(
//         children: [
//           Image.asset('assets/background.jpg'),
//           InformasiPengguna(),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 180),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20)
//                   )
//                 ),
//                 margin: EdgeInsets.zero,
//                 child: Container(
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 50,),

//                       LabelBerita(),
//                       ListBerita(),

//                       SizedBox(height: 25,),

//                       Wrap(
//                         children: [
//                           TombolMenu(
//                             image: Image.asset('assets/icon1.png',
//                             width: 60,),
//                           ),
//                           TombolMenu(
//                             image: Image.asset('assets/icon2.png',
//                             width: 60,),
//                           ),
//                           TombolMenu(
//                             image: Image.asset('assets/icon4.png',
//                             width: 60,),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//         ],
//       ),
//     );
//   }
// }

// class TombolMenu extends StatelessWidget {
//   final Image? image;
//   const TombolMenu({
//     Key? key,
//     this.image
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 9,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)
//       ),
//       margin: EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: image ?? SizedBox()
//       ),
//     );
//   }
// }

// class ListBerita extends StatelessWidget {
//   const ListBerita({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 140,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset('assets/berita1.jpg', height: 120,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset('assets/berita2.jpg', height: 120,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset('assets/berita3.jpg', height: 120,),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LabelBerita extends StatelessWidget {
//   const LabelBerita({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 23),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Text('Berita')),
//     );
//   }
// }

// class NavigatorBawah extends StatelessWidget {
//   const NavigatorBawah({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.house),
//           label: 'Home'
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.newspaper),
//           label: 'Berita'
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(FontAwesomeIcons.gear),
//           label: 'Pengaturan'
//         ),
//       ],
//     );
//   }
// }

// class InformasiPengguna extends StatelessWidget {
//   const InformasiPengguna({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: Image.asset('assets/foto.jpg',
//               width: 60,),
//           ),
//           SizedBox(width: 20,),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Hi, Nako',
//                 style: TextStyle(fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//                   )
//                 ),
//                 Text('Naffiilham@gmail.com',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Image.asset('assets/bell.png', width: 40,)
//         ],
//       ),
//     );
//   }
// }
