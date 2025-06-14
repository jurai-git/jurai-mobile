import 'package:either_dart/either.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel{
  late HomeRemoteRepository homeRemoteRepository;


  @override
  AsyncValue<dynamic>? build(){
    homeRemoteRepository = ref.watch(homeRemoteRepositoryProvider);
    return null;
  }
  
  Future<void> getAllRequerentes() async{
    final notifier = ref.read(requerenteListProvider.notifier);
    notifier.setLoading();
    final res = await homeRemoteRepository.getAllRequerentes();

    switch(res){
      case Left(value: final l):
        notifier.setError(l.message, StackTrace.current);
        state = AsyncValue.error(l.message, StackTrace.current);
      case Right(value: final r):
        notifier.setRequerenteList(r); 
        state = AsyncValue.data(r);
    };
  }

  Future<void> getAllDemandas() async {
    final notifier = ref.read(allDemandaListProvider.notifier);
    notifier.setLoading();
    final res = await homeRemoteRepository.getAllDemandas();

    switch (res) {
      case Left(value: final l):
        notifier.setError(l.message, StackTrace.current);
        state = AsyncValue.error(l.message, StackTrace.current);
      case Right(value: final r):
        notifier.setAllDemandaList(r);
        state = AsyncValue.data(r);
    }
  }

  Future<void> getAllDemandasFromRequerente({
    required int id_requerente
    }) async {
      final notifier = ref.read(demandaListProvider.notifier);
      notifier.setLoading();
      final res = await homeRemoteRepository.getAllDemandasFromRequerente(id_requerente: id_requerente);

      switch (res) {
        case Left(value: final l):
          notifier.setError(l.message, StackTrace.current);
          state = AsyncValue.error(l.message, StackTrace.current);
        case Right(value: final r):
          notifier.setDemandaList(r);
          state = AsyncValue.data(r);
      }
    }

    Future<void> getProbability({
      required String text
    }) async {
      state = AsyncValue.loading();
      final res = await homeRemoteRepository.probability(text: text);

      switch (res) {
        case Left(value: final l):
          state = AsyncValue.error(l.message, StackTrace.current);
        case Right(value: final r):
          state = AsyncValue.data(r);
      }
    }
}