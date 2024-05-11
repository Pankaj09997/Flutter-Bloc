import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final email = event.email;
        final password = event.password;
        if (password.length < 6) {
          return emit(AuthFailure(message: 'Invalid length of the password'));
        }
        await Future.delayed(const Duration(seconds: 1));
        emit(AuthSuccess(message: '$email-$password'));
      } catch (e) {
        emit(AuthFailure(message: '$e'));
      }
    });
on<LogoutRequested>((event, emit) async {
  emit(AuthLoading());
  try {
    await Future.delayed(Duration(seconds: 1));
    emit(AuthInitial());
  } catch (e) {
    return emit(AuthFailure(message: 'Unable'));
  }
});
  }
}

