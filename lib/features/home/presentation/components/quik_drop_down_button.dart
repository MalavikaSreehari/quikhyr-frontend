import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/constants/quik_asset_constants.dart';
import '../../../../common/constants/quik_colors.dart';
import '../../../../common/constants/quik_spacings.dart';
import '../../cubit/workerlist_cubit.dart';
import '../../../../models/sub_service_category_model.dart';

class QuikDropDownButtonSubservice extends StatefulWidget {
  final List<SubserviceModel> subservices;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double height;
  final Function(SubserviceModel subservice)? onSubserviceSelected;

  const QuikDropDownButtonSubservice({
    Key? key,
    required this.subservices,
    this.onSubserviceSelected,
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
            hint: DropdownMenuItem(
              // onTap: () {
              //   // context.read<WorkerlistCubit>().getWorkersBySubserviceId(
              //   //     subserviceId: subservice.id);
              // },
              value: "All Subservices",
              child: Row(
                children: [
                  QuikSpacing.hS20(),
                  const Text("All Subservices"),
                ],
              ),
            ),
            borderRadius: BorderRadius.circular(16),
            icon: Row(
              children: [
                SvgPicture.asset(
                  QuikAssetConstants.dropDownArrowSvg,
                  colorFilter: ColorFilter.mode(
                      widget.foregroundColor ?? textInputIconColor,
                      BlendMode.srcIn),
                ),
                QuikSpacing.hS24(),
              ],
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
                onTap: () {
                  if (subservice.serviceName == "All") {
                    context
                        .read<WorkerlistCubit>()
                        .getWorkersByServiceId(serviceId: subservice.serviceId);
                  } else {
                    context
                        .read<WorkerlistCubit>()
                        .getWorkersBySubserviceId(subserviceId: subservice.id);
                  }
                },
                value: subservice,
                child: Row(
                  children: [
                    QuikSpacing.hS20(),
                    Text(subservice.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (SubserviceModel? newSubservice) {
              setState(() {
                selectedSubservice = newSubservice;
              });
              if (widget.onSubserviceSelected != null) {
                widget.onSubserviceSelected!(newSubservice!);
              }
            },
          ),
        ),
      ),
    );
  }
}
