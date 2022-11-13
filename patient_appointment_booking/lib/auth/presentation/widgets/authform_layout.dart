import 'package:flutter/material.dart';

class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    Key? key,
    required this.formKey,
    required this.controllerList,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final List<Map<String, dynamic>> controllerList;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => TextFormField(
                  controller: controllerList[index]['controller'],
                  validator: (value) =>
                      value!.isEmpty ? 'Field cannot be empty' : null,
                  obscureText: controllerList[index]['hint'] == 'Password'
                      ? true
                      : false,
                  decoration: InputDecoration(
                      hintText: controllerList[index]['hint'],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: controllerList.length));
  }
}
