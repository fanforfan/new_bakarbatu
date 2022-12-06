import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_nav/bottom_nav_bloc.dart';

class BottomNavbar extends StatefulWidget {
  final BottomNavState state;

  const BottomNavbar({Key? key, required this.state}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.state.idMenu == 2 ? const Color(0xFF800000) : Colors.white,
      height: 96,
      child: Stack(
        children: [
          /// UNACTIVE MENU
          Column(
            children: [
              const SizedBox(height: 30,),
              Container(
                height: 66,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Colors.grey
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemMenus(
                          colors: widget.state.idMenu == 0 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_article.png',
                          size: 19.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 0
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: widget.state.idMenu == 1 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_mic.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 1
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      const SizedBox(width: 50,),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: widget.state.idMenu == 3 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_fotoimage.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 3
                            ));
                          }
                      ),
                      const SizedBox(width: 16,),
                      _itemMenus(
                          colors: widget.state.idMenu == 4 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                          image: 'assets/icons/ic_video.png',
                          size: 20.0,
                          pressed: () {
                            BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                                statusMenu: true,
                                idMenu: 4
                            ));
                          }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          /// ACTIVE MENU
          Container(
              padding: const EdgeInsets.only(bottom: 26),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  BlocProvider.of<BottomNavBloc>(context).add(ChangeBottomNav(
                      statusMenu: true,
                      idMenu: 2
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: widget.state.idMenu == 2 ? const Color(0xFFFFFFFF) : const Color(0xFFD0D0D0),
                      border: Border.all(width: 5, color: widget.state.idMenu == 2 ? const Color(0xFF800000) : Colors.white)
                  ),
                  width: 70,
                  child: Center(
                    child: Image.asset(
                      'assets/icons/ic_home.png',
                      width: 40,
                      color: const Color(0xFF800000),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _itemMenus({
    required Color colors,
    required String image,
    required double size,
    required Function() pressed
  }) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: colors
        ),
        width: 50,
        child: Center(
          child: Image.asset(image, width: size, color: const Color.fromARGB(255, 142, 0, 0),),
        ),
      ),
    );
  }
}
