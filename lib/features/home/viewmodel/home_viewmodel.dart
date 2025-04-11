import 'package:either_dart/either.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel{
  late HomeRemoteRepository homeRemoteRepository;


  @override
  AsyncValue<Requerente>? build(){
    homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);
    return null;
  }
  Future<List<Requerente>> getAllRequerentes() async{
    final res = await homeRemoteRepository.getAllRequerentes();

    return switch(res){
      Left(value: final l) => throw l.message,
      Right(value: final r) => r,
    };
  }
}