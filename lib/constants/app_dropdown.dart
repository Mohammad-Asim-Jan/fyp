import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sea/constants/colors.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  });

  final List<String> items;
  final String labelText;
  final String? selectedItem;
  final void Function(String?)? onChanged;

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjust the height as needed
      width: double.infinity, // Use the full width of the parent container
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
          menuProps: const MenuProps(
            backgroundColor: Colors.black,
          ),
          itemBuilder: (context, item, isSelected) {
            return Container(
              color: Colours.kContainerColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                item,
                style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
              ),
            ),
            );
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          dropdownSearchDecoration: InputDecoration(
            hintText: widget.labelText,
            filled: true,
            fillColor:  Colours.kContainerColor,
            contentPadding: const EdgeInsets.only(left: 10, top: 15),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            // floatingLabelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
        ),
        dropdownButtonProps: const DropdownButtonProps(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ),
        items: widget.items,
        onChanged: widget.onChanged,
        selectedItem: widget.selectedItem,
      ),
    );
  }
}
