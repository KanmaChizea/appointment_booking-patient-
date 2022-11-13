import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entitis/user_data.dart'; /*  */
import '../bloc/edit_profile_cubit.dart';
import '../bloc/user_data_cubit.dart';
import '../../../core/responsive.dart';
import '../widgets/appbar.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/welcome_user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        BuildContext dialogContext = context;
        if (state is EditProfileFailed) {
          Navigator.pop(dialogContext);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Could not edit profile'),
            duration: Duration(seconds: 3),
          ));
        }
        if (state is EditProfileSuccess) {
          Navigator.pop(dialogContext);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Profile edited successfully'),
            duration: Duration(seconds: 3),
          ));
        }
        if (state is EditProfileLoading) {
          showDialog(
              context: context,
              builder: (context) {
                dialogContext = context;
                return const AlertDialog(
                  elevation: 10,
                  content: Center(child: CircularProgressIndicator()),
                );
              });
        }
      },
      child: Scaffold(
        appBar: DashboardAppbar(context: context, title: 'Edit profile'),
        body: SingleChildScrollView(
            padding: Responsive.isDesktop(context)
                ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
                : const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Responsive.isDesktop(context))
                  const Text(
                    'Edit profile',
                    style: TextStyle(color: Colors.black, fontSize: 36),
                  ),
                const SizedBox(height: 16),
                if (Responsive.isMobile(context))
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [WelcomeUser(), BookAppointmentButton()],
                    ),
                  ),
                const SizedBox(height: 16),
                Center(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
                  width: MediaQuery.of(context).size.width > 390 ? 500 : null,
                  decoration: BoxDecoration(
                      border: MediaQuery.of(context).size.width > 650
                          ? Border.all(width: 2, color: Colors.grey)
                          : null),
                  child: const EditProfileForm(),
                ))
              ],
            )),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController department;
  late TextEditingController faculty;
  late TextEditingController id;

  @override
  void initState() {
    id = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    department = TextEditingController();
    faculty = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserData>(
      builder: (context, state) {
        id.text = state.id;
        firstName.text = state.firstName;
        lastName.text = state.lastName;
        department.text = state.department;
        faculty.text = state.faculty;
        final List<String> label = [
          'ID',
          'FIRST NAME',
          'LAST NAME',
          'FACULTY',
          'DEPARTMENT'
        ];
        final List<TextEditingController> controllerList = [
          id,
          firstName,
          lastName,
          faculty,
          department
        ];
        return Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: label.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return TextField(
                    controller: controllerList[index],
                    decoration: InputDecoration(
                        labelText: label[index],
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder()),
                  );
                }),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {
                  final userdata = UserData(
                      firstName: firstName.text,
                      lastName: lastName.text,
                      department: department.text,
                      faculty: faculty.text,
                      id: id.text);
                  context.read<EditProfileCubit>().editProfile(userdata);
                },
                child: const Text('Save'))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    id.dispose();
    firstName.dispose();
    lastName.dispose();
    department.dispose();
    faculty.dispose();
    super.dispose();
  }
}
