part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  final bool? statusMenu;
  final int? idMenu;

  const BottomNavState({
    this.statusMenu,
    this.idMenu
  });

  @override
  List<Object?> get props => [
    statusMenu,
    idMenu
  ];

  BottomNavState copyWith({
    bool? statusMenu,
    int? idMenu
  }) {
    return BottomNavState(
      statusMenu: statusMenu ?? this.statusMenu,
      idMenu: idMenu ?? this.idMenu
    );
  }
}
