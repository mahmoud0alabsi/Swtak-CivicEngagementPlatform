import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'about.dart';
import 'help.dart';
import 'privacy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'الملف الشخصي',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 89,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(13),
                    leading: CircleAvatar(
                      radius: 21.5,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/account_person.svg', // Replace with your asset path
                        fit: BoxFit.cover,
                        width: 43, // Adjust to fit within the CircleAvatar
                        height: 43,
                      ), // Optional, removes default background
                    ),
                    title: Text(
                      context.read<UserManagerBloc>().user.fullName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      context.read<UserManagerBloc>().user.nationalId,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/settings.svg', // Update this path with your SVG file's path
                    height: 23, // Set the desired height
                    width: 23, // Set the desired width
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode
                            .srcIn), // Optionally, you can set a color if needed
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'الإعدادات',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),

              // Your other widgets here, including user profile
              const SizedBox(height: 6),
              // Dark Mode Switch
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor:
                    Colors.grey.withOpacity(0.3), // Light grey shadow color
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/dark_mode.svg', // Dark Mode icon path
                      height: 23,
                      width: 23,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  title: Text(
                    'الوضع المظلم',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  // reflect the current state of the switch
                  trailing: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1415926535),
                    child: CustomSwitch(
                      value: false, // Initial state of the switch
                      onChanged: (value) {
                        // Handle Dark Mode toggle logic here
                      },
                      activeIcon: SvgPicture.asset(
                        'assets/icons/toggle_check.svg', // Custom checked icon for dark mode
                        height: 11, // Set icon size here
                        width: 11,
                      ),
                      inactiveIcon: Container(), // No icon for inactive state
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5),
              // Language Switch
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/language.svg', // Language icon path
                      height: 23,
                      width: 23,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                    ),
                  ),
                  title: Text(
                    'اللغة',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: CustomSwitchLanguage(
                    value: true,
                    onChanged: (value) {
                      // Handle Language toggle logic here
                    },
                    activeIcon: SvgPicture.asset(
                      'assets/icons/toggle_language_ar.svg', // Icon for Arabic "ع" when active
                      height: 14, // Icon size
                      width: 14,
                    ),
                    inactiveIcon: SvgPicture.asset(
                      'assets/icons/toggle_language_en2.svg', // Icon for English "en" when inactive
                      height: 14, // Icon size
                      width: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Notifications Switch
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6), // Padding inside the ListTile
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/notifications.svg', // Notifications icon path
                      height: 23,
                      width: 23,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn),
                    ),
                  ),
                  title: Text(
                    'الإشعارات',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: CustomSwitchLanguage(
                    value: true, // Initial state of the switch
                    onChanged: (value) {
                      // Handle Notifications toggle logic here
                    },
                    activeIcon: SvgPicture.asset(
                      'assets/icons/toggle_notifications_on.svg', // Icon for active state (notifications on)
                      height: 14, // Set icon size here
                      width: 14,
                    ),
                    inactiveIcon: SvgPicture.asset(
                      'assets/icons/toggle_notifications_off2.svg', // Icon for inactive state (notifications off)
                      height: 14, // Set icon size here
                      width: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Cusotm Class for swtichs
              //////////////////////////////////////////////////////////

              /////////////////////////////////////////////////////////
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ), // Padding inside the ListTile

                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/password.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                  ),
                  title: Text(
                    'تغيير الرمز السري',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onTap: () {
                    //Navigator.push(
                    // context,
                    // MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),  صفحة معتز نفسها
                    // );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6), // Padding inside the ListTile
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/logout.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onTap: () {
                    // context.read<LogoutBloc>().add(Logout());
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/help.svg', // Update this path with your SVG file's path
                    height: 23, // Set the desired height
                    width: 23, // Set the desired width
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode
                            .srcIn), // Optionally, you can set a color if needed
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'المساعدة',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6), // Padding inside the ListTile
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/privacy.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                  ),
                  title: Text(
                    'سياسة الخصوصية',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6), // Padding inside the ListTile
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/support.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                  ),
                  title: Text(
                    'المساعدة والدعم الفني',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpAndSupportPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1, // Slight elevation for shadow effect
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6), // Padding inside the ListTile
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    child: SvgPicture.asset(
                      'assets/icons/about.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                  ),
                  title: Text(
                    'حول التطبيق',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//الواجهة الثانية :)
class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'معلوماتي',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 22, bottom: 30, right: 22, left: 22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تعديل المعلومات الشخصية:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 14),

              // الرقم الوطني
              const Padding(
                padding: EdgeInsets.only(top: 7.5, bottom: 5.5),
                child: Text('الرقم الوطني',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: TextEditingController(
                  text: context.read<UserManagerBloc>().user.nationalId,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // حواف دائرية
                  ),
                  hintText: 'أدخل الرقم الوطني',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.70),
                  ),
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // حواف دائرية عند عدم التركيز
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12), // حواف دائرية عند التركيز
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // الاسم الرباعي
              const Padding(
                padding: EdgeInsets.only(top: 7.5, bottom: 5.5),
                child: Text('الاسم الرباعي',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: TextEditingController(
                  text: context.read<UserManagerBloc>().user.fullName,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // حواف دائرية
                  ),
                  hintText: 'أدخل الاسم الرباعي',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.70),
                  ),
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // حواف دائرية عند عدم التركيز
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12), // حواف دائرية عند التركيز
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // مكان الإقامة
              const Padding(
                padding: EdgeInsets.only(top: 7.5, bottom: 5.5),
                child: Text('مكان الإقامة',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: TextEditingController(
                  text: context.read<UserManagerBloc>().user.residence,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // حواف دائرية
                  ),
                  hintText: 'أدخل مكان الإقامة',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.70),
                  ),
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // حواف دائرية عند عدم التركيز
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12), // حواف دائرية عند التركيز
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // رقم الهاتف
              const Padding(
                padding: EdgeInsets.only(top: 7.5, bottom: 5.5),
                child: Text('رقم الهاتف',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: TextEditingController(
                  text: context.read<UserManagerBloc>().user.phoneNumber,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // حواف دائرية
                  ),
                  hintText: 'أدخل رقم الهاتف',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.70),
                  ),
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // حواف دائرية عند عدم التركيز
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12), // حواف دائرية عند التركيز
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // زر التحديث
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      // Define the shape with border radius
                      borderRadius: BorderRadius.circular(
                          12.0), // Set your desired radius here
                    ),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تحديث',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildReadOnlyField(String label, String value) {
  return TextFormField(
    initialValue: value,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget activeIcon;
  final Widget inactiveIcon;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isActive = !isActive;
        // });
        // widget.onChanged(isActive);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 46.8, // Total width of the switch
        height: 27, // Total height of the switch
        padding: const EdgeInsets.symmetric(
            horizontal: 2.4), // Padding for white circle movement
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27 / 2),
          color: isActive
              ? Theme.of(context).colorScheme.primary // Background when active
              : Theme.of(context)
                  .colorScheme
                  .surface, // Background when inactive
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The SVGs are placed in a row to toggle visibility
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // When inactive, the icon on the left shows (e.g., inactive icon)
            //     !isActive ? widget.inactiveIcon : Container(),
            //     // When active, the icon on the right shows (e.g., active icon)
            //     isActive ? widget.activeIcon : Container(),
            //   ],
            // ),
            // The white circle that moves
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
                  isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 23.4,
                height: 23.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White circle color
                ),
                // child: Center(
                //   child: isActive
                //       ? widget
                //           .activeIcon // Active icon (inside the circle when ON)
                //       : widget
                //           .inactiveIcon, // Inactive icon (inside the circle when OFF)
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitchLanguage extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget activeIcon;
  final Widget inactiveIcon;

  const CustomSwitchLanguage({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  CustomSwitchLanguageState createState() => CustomSwitchLanguageState();
}

class CustomSwitchLanguageState extends State<CustomSwitchLanguage> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isActive = !isActive;
        // });
        // widget.onChanged(isActive);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 46.8, // Total width of the switch
        height: 27, // Total height of the switch
        padding: const EdgeInsets.symmetric(
            horizontal: 2.4), // Padding for white circle movement
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27 / 2),
          color: Theme.of(context)
              .colorScheme
              .primary, // Background stays red, regardless of state
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // White circle that moves from left to right
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
                  isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 23.4,
                height: 23.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White circle color
                ),
                child: Center(
                  child: isActive
                      ? widget.activeIcon // Show "ع" when active
                      : widget.inactiveIcon, // Show "en" when inactive
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
