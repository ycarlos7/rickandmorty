import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rickandmorty/character_list.dart';
import 'package:rickandmorty/repository/rickandmorty_repository.dart';

import 'components/app_colors.dart';
import 'cubit/rickandmorty_cubit.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: GestureDetector(
            child: SvgPicture.asset('images/Logo.svg'),
            onTap: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => RickandMortyCubit(
                      RickandMortyRepositoryImplementation(context),
                    ),
                    child: const CharacterListScreen(),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
