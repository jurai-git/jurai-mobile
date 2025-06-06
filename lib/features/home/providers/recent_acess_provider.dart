import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';

class RecentReqAcessListNotifier extends StateNotifier<AsyncValue<List<Requerente>>>{
  RecentReqAcessListNotifier() : super(AsyncValue.data([]));

  void setRecentReqAcessList(Requerente requerente){
    final currentList = state.value ?? [];
      
    final newList = List<Requerente>.from(currentList);

    newList.removeWhere((r) => r == requerente);

    newList.insert(0, requerente);

    state = AsyncValue.data(newList);
  }

  void clear(){
    state = AsyncValue.data([]);
  }

}

final recentReqAcessListProvider = StateNotifierProvider<RecentReqAcessListNotifier, AsyncValue<List<Requerente>>>((ref) {
  return RecentReqAcessListNotifier();
});