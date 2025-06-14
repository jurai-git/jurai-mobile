import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jurai/features/auth/service/token_storage_service.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/models/probability.dart';
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
        .get(Uri.parse("https://jurai-server.onrender.com/advogado/requerentes"), headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : ''
        });
        var resBodyMap = jsonDecode(res.body);
        if(res.statusCode / 100 != 2){
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

  Future<Either<FlutterError, List<Demanda>>> getAllDemandas() async{
    try{
      String? token = await tokenService.getToken();
      
      final res = await http
        .get(Uri.parse("https://jurai-server.onrender.com/advogado/demandas"), headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : ''
        });
        var resBodyMap = jsonDecode(res.body);
        if(res.statusCode / 100 != 2){
          return Left(FlutterError(resBodyMap['detail']));
        }

        resBodyMap = resBodyMap['demandas'] as List;

        List<Demanda> demandas = [];

        for(final map in resBodyMap){
          demandas.add(Demanda.fromMap(map));
        }
        print(demandas);

        return Right(demandas);
    } catch (e) {
      return Left(FlutterError(e.toString()));
    }
  }

  Future<Either<FlutterError, List<Demanda>>> getAllDemandasFromRequerente({
    required int id_requerente,
  }) async {
    try{
      String? token = await tokenService.getToken();
      
      final res = await http.get(
        Uri.parse("https://jurai-server.onrender.com/advogado/requerente/${id_requerente.toString()}/demandas"), 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : ''
        },
        );

        var resBodyMap = jsonDecode(res.body);
        if(res.statusCode / 100 != 2){
          return Left(FlutterError(resBodyMap['detail']));
        }

        resBodyMap = resBodyMap['demanda_list'] as List;

        List<Demanda> demandas = [];

        for(final map in resBodyMap){
          demandas.add(Demanda.fromMap(map));
        }
        print(demandas);

        return Right(demandas);
    } catch (e) {
      return Left(FlutterError(e.toString()));
    }
  }

  Future<Either<FlutterError, Probability>> probability({
    required String text,
  }) async{
    try{
      String? token = await tokenService.getToken();
      
      final res = await http.post(
        Uri.parse("https://jurai-server.onrender.com/ai/probability"), 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? 'Bearer $token' : ''
        },
        body: jsonEncode({
          'text': text
        })
      );

      var resBodyMap = jsonDecode(res.body);
      var probabilities = resBodyMap['probabilities'];
      
      if(res.statusCode / 100 != 2){
        return Left(FlutterError(resBodyMap['detail']));
      }

      return Right(Probability(input: resBodyMap['input'], predicted: resBodyMap['predicted_class'], negativePercentage: probabilities['negative'], partialPercentage: probabilities['partial'], positivePercentage: probabilities['positive']));
    } catch (e) {
      return Left(FlutterError(e.toString()));
    }
  }
}