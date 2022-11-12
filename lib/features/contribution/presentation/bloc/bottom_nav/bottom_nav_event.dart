part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {}

class ChangeBottomNav extends BottomNavEvent {
  final bool? statusMenu;
  final int? idMenu;

  ChangeBottomNav({this.statusMenu, this.idMenu});

  @override
  List<Object?> get props => [statusMenu, idMenu];

}
