import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/suggestions_metadata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Filtercard extends StatefulWidget {
  final String type;
  final MunicipalitySuggestionsBloc? bloc;
  const Filtercard({super.key, required this.type, required this.bloc});

  @override
  State<Filtercard> createState() => _FiltercardState();
}

class _FiltercardState extends State<Filtercard> {
  bool _openFilter = false;
  String? selectedGovernorate;
  String? selectedCity;
  String? selectedArea;

  final _filterFormKey = GlobalKey<FormState>();
  bool isFiltering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0.0,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/share2.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "شارك وتصفح اخر الإقتراحات",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const Spacer(),
                  if (widget.type == 'municipality')
                    IconButton(
                      iconSize: 40.0,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(
                        tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // the '2023' part
                      ),
                      onPressed: () {
                        setState(() {
                          _openFilter = !_openFilter;
                        });
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/s2.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.type == 'municipality')
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        isFiltering
                            ? '$selectedGovernorate - ${selectedCity!} - ${selectedArea!}'
                            : 'العاصمة - الجبيهة - أمانة عمان الكبرى',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              if (_openFilter) ...[
                const SizedBox(height: 20),
                Form(
                  key: _filterFormKey,
                  child: Column(
                    children: [
                      _buildDropdown(
                          'المحافظة', governorates, selectedGovernorate,
                          (value) {
                        setState(() {
                          selectedGovernorate = value;
                          selectedCity = null;
                          selectedArea = null;
                        });
                      }, Icons.location_on_outlined),
                      const SizedBox(height: 20),
                      _buildDropdown(
                          'المنطقة',
                          municipalities[selectedGovernorate] ?? [],
                          selectedCity, (value) {
                        setState(() {
                          selectedCity = value;
                          selectedArea = null;
                        });
                      }, Icons.location_on_outlined),
                      const SizedBox(height: 20),
                      _buildDropdown(
                        'البلدية',
                        areas[selectedCity] ?? [],
                        selectedArea,
                        (value) {
                          setState(() {
                            selectedArea = value;
                          });
                        },
                        Icons.location_on_outlined,
                        autoSelectIfOne: true,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          if (governorates.isNotEmpty) {
                            setState(() {
                              selectedGovernorate = null;
                              selectedCity = null;
                              selectedArea = null;
                              isFiltering = false;

                              widget.bloc!.add(
                                FilterMunicipalitySuggestions(
                                  governorate: '',
                                  area: '',
                                  municipality: '',
                                ),
                              );
                            });
                          }
                        },
                        child: Text(
                          'إزالة الفلتر',
                          style: TextStyle(
                            fontSize: 14,
                            color: selectedGovernorate != null
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_filterFormKey.currentState!.validate() == true) {
                            try {
                              widget.bloc!.add(
                                FilterMunicipalitySuggestions(
                                  governorate: selectedGovernorate ?? '',
                                  area: selectedCity ?? '',
                                  municipality: selectedArea ?? '',
                                ),
                              );

                              setState(() {
                                isFiltering = true;
                              });
                            } catch (e) {}
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        iconAlignment: IconAlignment.start,
                        label: Text(
                          'فلترة',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: Icon(
                          Icons.filter_alt_rounded,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

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
}
