import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
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

  
}