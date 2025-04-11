import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jurai/features/auth/models/advogado.dart';
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
    final token = tokenService.getToken();
    try{
      final res = await http
        .get(Uri.parse("https://jurai-server.onrender.com/advogado/requerentes"), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
        var resBodyMap = jsonDecode(res.body);
        if(res.statusCode != 200){
          return Left(FlutterError(resBodyMap['detail']));
        }

        resBodyMap = resBodyMap as List;

        List<Requerente> requerentes = [];

        for(final map in resBodyMap){
          requerentes.add(Requerente.fromMap(map));
        }

        return Right(requerentes);
    } catch (e) {
      return Left(FlutterError(e.toString()));
    }
  }
}