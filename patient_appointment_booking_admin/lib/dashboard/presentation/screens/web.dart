import 'package:flutter/material.dart';

import '../widgets/filter.dart';
import '../widgets/search.dart';

class WebDashboard extends StatelessWidget {
  const WebDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(),
                  SizedBox(height: 8),
                  FilterButton(),
                ],
              ),
            )),
        Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(left: BorderSide(width: 1, color: Colors.grey))),
              child: SingleChildScrollView(
                child: Column(),
              ),
            ))
      ],
    );
  }
}
