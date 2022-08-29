import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/app_colors.dart';

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
          child: SvgPicture.asset('images/svg/marvel.svg'),
        ));
  }
}
