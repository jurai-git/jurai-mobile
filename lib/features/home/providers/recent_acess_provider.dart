import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';

class RecentReqAcessListNotifier extends StateNotifier<List<Requerente>>{
  RecentReqAcessListNotifier() : super([]);

  void setRecentReqAcessList(Requerente requerente){
    for(Requerente r in state){
      if(r == requerente){
        state.remove(r);
        break;
      }
    }
    state.insert(0, requerente);
  }

  void clear(){
    state = [];
  }

}

final recentReqAcessListProvider = StateNotifierProvider<RecentReqAcessListNotifier, List<Requerente>>((ref) {
  return RecentReqAcessListNotifier();
});