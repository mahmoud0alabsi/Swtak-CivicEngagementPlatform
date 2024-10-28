import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'suggestions_metadata.dart';

class NewSuggestion extends StatefulWidget {
  final ParliamentSuggestionsBloc parliamentSuggestionsBloc;
  const NewSuggestion({super.key, required this.parliamentSuggestionsBloc});

  @override
  NewSuggestionPageState createState() => NewSuggestionPageState();
}

class NewSuggestionPageState extends State<NewSuggestion> {
  late ParliamentSuggestionsBloc parliamentSuggestionsBloc;

  String? suggestionType;
  String? selectedGovernorate;
  String? selectedCity;
  String? selectedArea;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _parliamentFormKey = GlobalKey<FormState>();
  final _municipalityFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    parliamentSuggestionsBloc = widget.parliamentSuggestionsBloc;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: suggestionType,
                items: ['النواب', 'البلدية']
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          item,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    suggestionType = value!;
                  });
                },
                validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  label: const Text(
                    'نوع المقترح',
                    style: TextStyle(
                      color: Color.fromARGB(255, 123, 123, 123),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.share_outlined,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 16),
              suggestionType == 'النواب'
                  ? parliamentForm(screenWidth, context)
                  : suggestionType == 'البلدية'
                      ? municipalityForm(screenWidth, context)
                      : Center(
                          child: Text(
                            'الرجاء اختيار نوع المقترح',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer parliamentForm(double screenWidth, BuildContext context) {
    return BlocConsumer<ParliamentSuggestionsBloc, ParliamentSuggestionsState>(
      bloc: parliamentSuggestionsBloc,
      listener: (context, state) {
        if (state is SuggestionPosted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم نشر المقترح بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          titleController.clear();
          descriptionController.clear();

          // pop the page
          Navigator.pop(context);
        }
        if (state is SuggestionPostError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('حدث خطأ أثناء نشر المقترح'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        parliamentSuggestionsBloc.add(GetMySuggestions(
          context.read<UserManagerBloc>().user.uid,
        ));

        if (state is ParliamentMySuggestionsLoading) {
          return const LoadingSpinner();
        }

        if (parliamentSuggestionsBloc.mySuggestions.length >= 3) {
          return Center(
            child: Text(
              'لا يمكنك نشر أكثر من 3 مقترحات، يرجى الإنتظار حتى انتهاء مدة المقترحات الحالية، أو حذف مقترحاتك',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Form(
          key: _parliamentFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildParliamentCard(
                screenWidth,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_parliamentFormKey.currentState!.validate()) {
                      // _showPublishConfirmationDialog();
                      parliamentSuggestionsBloc.add(
                        PostSuggestion(
                          uid: context.read<UserManagerBloc>().user.uid,
                          name: context
                              .read<UserManagerBloc>()
                              .user
                              .fullName
                              .split(' ')[0],
                          title: titleController.text,
                          details: descriptionController.text,
                          dateOfPost: DateTime.now(),
                          type: '',
                          tags: const [],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: state is PostingSuggestion
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'نشر',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(3.14159),
                              child: SvgPicture.asset(
                                'assets/icons/post.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                  BlendMode.srcIn,
                                ),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Form municipalityForm(double screenWidth, BuildContext context) {
    return Form(
      key: _municipalityFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMunicipalityCard(screenWidth),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_municipalityFormKey.currentState!.validate()) {
                  _showPublishConfirmationDialog();
                }
              },
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
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(
                            3.14159), // Flip horizontally using a Y-axis rotation
                      child: SvgPicture.asset(
                        'assets/icons/post.svg',
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'نشر',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'اقتراح جديد',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  List<Widget> _buildMainInfoCard() {
    return <Widget>[
      Text(
        'المعلومات الرئيسية',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      const SizedBox(height: 20),
      _buildTextField('العنوان', controller: titleController),
      const SizedBox(height: 20),
      _buildTextField('وصف المقترح...',
          controller: descriptionController, maxLines: 5),
    ];
  }

  Widget _buildParliamentCard(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildMainInfoCard(),
        ],
      ),
    );
  }

  Widget _buildMunicipalityCard(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildMainInfoCard(),
          const SizedBox(height: 24),
          Text(
            'معلومات الموقع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          _buildDropdown('المحافظة', governorates, selectedGovernorate,
              (value) {
            setState(() {
              selectedGovernorate = value;
              selectedCity = null;
              selectedArea = null;
            });
          }, Icons.location_on_outlined),
          const SizedBox(height: 20),
          _buildDropdown('المنطقة', municipalities[selectedGovernorate] ?? [],
              selectedCity, (value) {
            setState(() {
              selectedCity = value;
              selectedArea = null;
            });
          }, Icons.location_on_outlined),
          const SizedBox(height: 20),
          _buildDropdown('البلدية', areas[selectedCity] ?? [], selectedArea,
              (value) {
            setState(() {
              selectedArea = value;
            });
          }, Icons.location_on_outlined, autoSelectIfOne: true),
        ],
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(
    String hintText, {
    required TextEditingController controller,
    int maxLines = 1,
    Color hintTextColor = Colors.grey, // Allow hint text color customization
    double fieldHeight = 60.0, // Default field height
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) =>
          value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: hintTextColor, fontSize: 15, fontWeight: FontWeight.normal),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          // Default border
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 209, 209, 209)),
        ),
        enabledBorder: OutlineInputBorder(
          // Unfocused border
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Colors.grey), // Grey border for unfocused state
        ),
        focusedBorder: OutlineInputBorder(
          // Focused border
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .primary), // Customize focused border color
        ),
      ),
    );
  }

  // Helper method to build dropdown menus
// Helper method to build dropdown menus with TextOverflow to prevent overflow issues
  Widget _buildDropdown(String hintText, List<String> items,
      String? selectedItem, ValueChanged<String?> onChanged, IconData iconData,
      {bool autoSelectIfOne = false,
      Color hintTextColor = const Color.fromARGB(255, 123, 123, 123),
      double fieldHeight = 60.0}) {
    if (autoSelectIfOne && items.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedItem = items.first;
          onChanged(selectedItem);
        });
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownButtonFormField<String>(
          value: selectedItem,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      item,
                      overflow: TextOverflow.ellipsis, // Ellipsize long text
                      maxLines: 1, // Ensure single line with ellipsis
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            label: Text(
              hintText,
              style: TextStyle(
                color: hintTextColor,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: Theme.of(context)
                .colorScheme
                .surfaceContainer, // Set background color to white
            //contentPadding: EdgeInsets.symmetric(vertical: (fieldHeight - 30) / 2, horizontal: 12),  // Control field height
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: Colors.grey), // Grey border color
            ),
            enabledBorder: OutlineInputBorder(
              // Unfocused border
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  color: Colors.grey), // Grey border color for unfocused state
            ),
            focusedBorder: OutlineInputBorder(
              // Focused border color
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .primary), // Customize the focused border color
            ),
            prefixIcon: Icon(iconData, size: 20.0, color: Colors.grey),
          ),
          isExpanded: true, // Ensure dropdown expands to fit available space
        );
      },
    );
  }

  void _showPublishConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Center(
            child: Text(
              'تأكيد',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20, // Consistent with the rest of the page
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'هل أنت متأكد من نشر المقترح؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjusted for consistency
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons
                            .warning_amber_outlined, // Use a more appropriate warning icon
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'تنبيه: لا يمكنك تعديل أو حذف المحتوى بعد النشر.',
                          style: TextStyle(
                            fontSize: 14, // Adjusted for consistency
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              2, // Allow two lines of text to avoid truncation
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0), // Adjust padding for cleaner look
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      'الرجوع',
                      style: TextStyle(
                        fontSize: 16, // Consistent font size
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold, // Bold for emphasis
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //_submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        fontSize: 16, // Consistent font size
                        fontWeight: FontWeight.bold, // Bold for emphasis
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
