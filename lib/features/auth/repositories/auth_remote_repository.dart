
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref){
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<FlutterError, Advogado>> signup({
    required String username,
    required String email,
    required String oab,
    required String password,
  }) async{
    try{
      final response = await http.post(
        Uri.parse("/advogado/new"),
        headers: {'Content-Type': 'application/json',},
        body: jsonEncode({
          'username': username,
          'email': email,
          'oab': oab,
          'password': password

        },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if(response.statusCode != 201){
        return Left(FlutterError(resBodyMap['detail']));
      }
      return Right(Advogado.fromMap(resBodyMap));
    } catch (e){
      return Left(FlutterError(e.toString()));
    }
  }

  Future<Either<FlutterError, Advogado>> login({
    required String username,
    required String password,
  }) async{
    try{
      final response = await http.post(
        Uri.parse("https://jurai-server.onrender.com/advogado/get"),
        headers: {'Content-Type': 'application/json',},
        body: jsonEncode({
          'username': username,
          'password': password
        },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if(response.statusCode != 201){
        return Left(FlutterError(resBodyMap['detail']));
      }
      return Right(Advogado.fromMap(resBodyMap));
    } catch (e){
      return Left(FlutterError(e.toString()));
    }
  }
}