import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/rickandmorty_state.dart';
import '../model/rickandmorty_model.dart';
import '../repository/rickandmorty_repository.dart';

class RickandMortyCubit extends Cubit<RickandMortyState> {
  final RickandMortyRepository rickandMortyRepository;
  RickandMortyCubit(this.rickandMortyRepository) : super(RickandMortyInitial());

  Future<void> getRickandMorty() async {
    try {
      emit(RickandMortyLoading());
      RickandMortyModel _rickandMortyModel =
          await rickandMortyRepository.getAll();
      emit(RickandMortyLoaded(rickandMortyModel: _rickandMortyModel));
    } catch (e) {
      emit(RickandMortyError(e.toString()));
    }
  }
}
