import 'package:either_dart/either.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel{
  late HomeRemoteRepository homeRemoteRepository;


  @override
  AsyncValue<List>? build(){
    homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);
    return null;
  }
  
  Future<void> getAllRequerentes() async{
    state = const AsyncValue.loading();
    final res = await homeRemoteRepository.getAllRequerentes();

    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => [ref.read(requerenteListProvider.notifier).setRequerenteList(r), state = AsyncValue.data(r)],
    };
    print(val);
  }

  Future<void> getAllDemandasFromRequerente({
    required int id_requerente
  }) async{
    state = AsyncValue.loading();
    final res = await homeRemoteRepository.getAllDemandasFromRequerente(id_requerente: id_requerente);

    final val = switch(res){
      Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }
}