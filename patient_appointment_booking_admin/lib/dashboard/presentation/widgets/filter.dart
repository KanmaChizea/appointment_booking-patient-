import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.filter_alt_outlined,
          color: Colors.grey,
        ),
        // const Spacer(),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton2(
                buttonHeight: 40,
                itemHeight: 40,
                value: 'All',
                items: ['All', 'Pending']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {}),
          ),
        )
      ],
    );
  }
}
