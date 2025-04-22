import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jurai/features/auth/service/token_storage_service.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_remote_repository.g.dart';

@riverpod
HomeRemoteRepository homeRemoteRepository(HomeRemoteRepositoryRef ref){
  return HomeRemoteRepository();
}

class HomeRemoteRepository {
  final TokenStorageService tokenService = TokenStorageService();
  Future<Either<FlutterError, List<Requerente>>> getAllRequerentes() async {
    try{
      String? token = await tokenService.getToken();
      
      final res = await http
        .post(Uri.parse("https://jurai-server.onrender.com/advogado/requerentes"), headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : ''
        });
        var resBodyMap = jsonDecode(res.body);
        if(res.statusCode != 201){
          return Left(FlutterError(resBodyMap['detail']));
        }

        resBodyMap = resBodyMap['requerentes_list'] as List;

        List<Requerente> requerentes = [];

        for(final map in resBodyMap){
          print("debug");
          requerentes.add(Requerente.fromMap(map));
        }
        print(requerentes);

        return Right(requerentes);
    } catch (e) {
      return Left(FlutterError(e.toString()));
    }
  }
}