import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CubitProviderMixin<T extends Cubit>{
  static T of<T extends Cubit>(BuildContext context, {bool listen = false}) {
    return BlocProvider.of<T>(context, listen: listen);
  }
}