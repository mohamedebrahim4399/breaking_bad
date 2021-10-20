import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_state.dart';
import 'package:breaking_bad/constants/my_colors.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetails extends StatelessWidget {
  final Character character;

  const CharactersDetails({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhit),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhit,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhit,
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }
  Widget checkIfQuotesAreLoaded(CharactersState state){
    if(state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    }
    return showProgressIndicator();
  }
  Widget displayRandomQuoteOrEmptySpace(QuotesLoaded state){
    var quotes = (state).quote;
    if(quotes.isNotEmpty){
      int randomQuoteIndex = Random().nextInt(quotes.length -1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: MyColors.myWhit,shadows: [
            Shadow(
              blurRadius: 7,color: MyColors.myYellow,offset: Offset(0,0),
            ),
          ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }
  Widget showProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getCharacterQuote(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo('Job :', character.jobs.join(' /')),
                      buildDivider(315.0),
                      buildCharacterInfo(
                          'Appeared in :', character.categoryForTwoSeries),
                      buildDivider(250.0),
                      buildCharacterInfo('Seasons :',
                          character.appearanceOfSeasons.join(' /')),
                      buildDivider(280.0),
                      buildCharacterInfo(
                          'Status :', character.statusIfDeadOrAlive),
                      buildDivider(300.0),
                      character.betterCallSaulAppearance.isEmpty
                          ? const SizedBox()
                          : buildCharacterInfo('Better Call Seasons :',
                              character.betterCallSaulAppearance.join(' /')),
                      character.betterCallSaulAppearance.isEmpty
                          ? const SizedBox()
                          : buildDivider(150.0),
                      buildCharacterInfo(
                          'Actor/Actress :', character.actorName),
                      buildDivider(235.0),
                      BlocBuilder<CharactersCubit,CharactersState>(builder: (context,state){
                        return checkIfQuotesAreLoaded(state);
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: character.betterCallSaulAppearance.isEmpty
                      ? MediaQuery.of(context).size.height - 360
                      : MediaQuery.of(context).size.height - 410,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
