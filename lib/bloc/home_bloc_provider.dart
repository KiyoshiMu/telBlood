import 'package:flutter/material.dart';
import 'package:telblood/bloc/home_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc homeBloc;
  final String uid;
  const HomeBlocProvider(
    {Key key, Widget child, this.homeBloc, this.uid})
    : super(key: key, child: child);
  static HomeBlocProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(HomeBlocProvider old) =>
    homeBloc != old.homeBloc;
}
