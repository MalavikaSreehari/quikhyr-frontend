import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quikhyr/common/constants/quik_asset_constants.dart';
import 'package:quikhyr/common/constants/quik_colors.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';

class QuikDropDownButtonSubservice extends StatefulWidget {
  final List<SubserviceModel> subservices;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;

  const QuikDropDownButtonSubservice({
    Key? key,
    required this.subservices,
    this.foregroundColor,
    this.backgroundColor,
    this.height = 54,
  }) : super(key: key);

  @override
  _QuikDropDownButtonSubserviceState createState() =>
      _QuikDropDownButtonSubserviceState();
}

class _QuikDropDownButtonSubserviceState
    extends State<QuikDropDownButtonSubservice> {
  SubserviceModel? selectedSubservice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? textInputBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<SubserviceModel>(
            icon: SvgPicture.asset(
              QuikAssetConstants.dropDownArrowSvg,
              colorFilter: ColorFilter.mode(
                  widget.foregroundColor ?? textInputIconColor,
                  BlendMode.srcIn),
            ),
            isExpanded: true,
            dropdownColor: widget.backgroundColor ?? textInputBackgroundColor,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.foregroundColor ??
                      Theme.of(context).colorScheme.onPrimary,
                ),
            value: selectedSubservice,
            items: widget.subservices.map((SubserviceModel subservice) {
              return DropdownMenuItem<SubserviceModel>(
                value: subservice,
                child: Text(subservice.name),
              );
            }).toList(),
            onChanged: (SubserviceModel? newSubservice) {
              setState(() {
                selectedSubservice = newSubservice;
              });
            },
          ),
        ),
      ),
    );
  }
}
