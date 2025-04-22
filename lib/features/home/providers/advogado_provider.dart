import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/models/advogado.dart';

class AdvogadoNotifier extends StateNotifier<Advogado?>{
  AdvogadoNotifier() : super(null);

  void setAdvogado(Advogado advogado){
    state = advogado;
  }

  void clear(){
    state = null;
  }
}

final advogadoProvider = StateNotifierProvider<AdvogadoNotifier, Advogado?>((ref) {
  return AdvogadoNotifier();
});