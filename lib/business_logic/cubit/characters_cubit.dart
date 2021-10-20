import 'package:bloc/bloc.dart';
import 'package:breaking_bad/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';


class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository;


  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  void getAllCharacters(){
    charactersRepository.gerAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
    });
  }

  void getCharacterQuote(String charName){
    charactersRepository.gerCharacterQuote(charName).then((quote) {
      emit(QuotesLoaded(quote));
    });
  }
}
