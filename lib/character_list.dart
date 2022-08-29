import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rickandmorty/components/app_colors.dart';
import 'package:rickandmorty/model/rickandmorty_model.dart';
import 'cubit/rickandmorty_cubit.dart';
import 'cubit/rickandmorty_state.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late RickandMortyCubit _cubit;
  int? _selectedIndex;
  String? _nameCharacter;
  String? _img;
  String? _gender;
  String? _type;
  String? _status;
  @override
  void initState() {
    _cubit = BlocProvider.of<RickandMortyCubit>(context);
    callCubit();
    super.initState();
  }

  void callCubit() {
    _cubit.getRickandMorty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Lista de Personagens",
          style: GoogleFonts.sourceSansPro(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      backgroundColor: AppColors.mainColor,
      body: BlocConsumer<RickandMortyCubit, RickandMortyState>(
        listener: (context, state) {
          if (state is RickandMortyLoaded) {
            print("AQUI ${state.rickandMortyModel!.results!.length}");
            _selectedIndex = state.rickandMortyModel!.results!.length;
          }
          if (state is RickandMortyError) {
            Scaffold.of(context);
            SnackBar(
              content: Text(state.error),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  if (state is RickandMortyLoaded) {
                    _nameCharacter =
                        state.rickandMortyModel!.results![index].name;
                    _img = state.rickandMortyModel!.results![index].image;
                    _gender = state.rickandMortyModel!.results![index].gender;
                    _type = state.rickandMortyModel!.results![index].type;
                    _status = state.rickandMortyModel!.results![index].status;
                  }

                  return Column(
                    children: [
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _nameCharacter!,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _gender!,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _type!,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(_img!),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Text(
                        _status!,
                        style: GoogleFonts.acme(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                }),
                itemCount: _selectedIndex ?? 0),
          );
        },
      ),
    );
  }
}
