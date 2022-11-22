import 'package:flutter/material.dart';

import '../../../responsive.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      SizedBox(height: 70, width: 70, child: Image.asset('logo.png')),
      const SizedBox(height: 8, width: 8),
      Text('UNIVERSITY OF BENIN HEALTH CENTER APPOINTMENTS',
          textAlign: TextAlign.center,
          style: Responsive.isMobile(context)
              ? Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold)
              : Responsive.isTablet(context)
                  ? Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black))
    ];
    return Responsive.isMobile(context)
        ? Column(
            children: content,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          );
  }
}
