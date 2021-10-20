
import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/models/quote.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {

  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuotesLoaded extends CharactersState {

  final List<Quote> quote;

  QuotesLoaded(this.quote);
}
