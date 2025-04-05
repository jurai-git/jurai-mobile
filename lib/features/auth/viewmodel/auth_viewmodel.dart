import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:jurai/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

//class UserState{
//  final Advogado adv;
//  final bool isLoading;
//  final String? errorMessage;

//  UserState({required this.adv, required this.isLoading, this.errorMessage});
//}

@riverpod
class AuthViewModel extends _$AuthViewModel{
  late AuthRemoteRepository authRemoteRepository;

  @override
  AsyncValue<Advogado>? build(){
    authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> signUpUser({
    required String username,
    required String email,
    required String oab,
    required String password,
  }) async{
    state = const AsyncValue.loading();
    final res = await authRemoteRepository.signup(username: username, email: email, oab: oab, password: password);

    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  Future<void> loginUser({
    required String username,
    required String password,
  }) async{
    state = const AsyncValue.loading();
    final res = await authRemoteRepository.login(username: username, password: password);

    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
    print(val);
  }

  
}