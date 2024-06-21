import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserCubit extends HydratedCubit<Map<String, Map<String, dynamic>>> {
  UserCubit() : super({});

  void cacheUserData(String userId, Map<String, dynamic> userData) {
    final updatedState = Map<String, Map<String, dynamic>>.from(state);
    updatedState[userId] = userData;
    emit(updatedState);
  }

  @override
  Map<String, Map<String, dynamic>>? fromJson(Map<String, dynamic> json) {
    return json
        .map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
  }

  @override
  Map<String, dynamic>? toJson(Map<String, Map<String, dynamic>> state) {
    return state;
  }
}
