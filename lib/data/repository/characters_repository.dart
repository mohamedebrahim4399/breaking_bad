import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';


class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> gerAllCharacters()async{
    final characters =await charactersWebServices.getAllCharacters();
    return characters.map((e) => Character.formJson(e)).toList();
  }

  Future<List<Quote>> gerCharacterQuote(String charName)async {
    final quote = await charactersWebServices.getCharacterQuotes(charName);
    return quote.map((e) => Quote.fromJson(e)).toList();
  }

}
