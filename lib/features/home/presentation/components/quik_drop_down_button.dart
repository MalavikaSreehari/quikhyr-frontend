import 'package:flutter/material.dart';
import 'package:quikhyr/models/sub_service_category_model.dart';

class QuikDropDownButtonSubService extends StatelessWidget {
  final List<SubserviceModel> subservices;
  final ValueChanged<SubserviceModel> onChanged;

  const QuikDropDownButtonSubService({
    Key? key,
    required this.subservices,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SubserviceModel>(
      items: subservices.map((SubserviceModel subservice) {
        return DropdownMenuItem<SubserviceModel>(
          value: subservice,
          child: Text(subservice.name),
        );
      }).toList(),
      onChanged: (SubserviceModel? selectedSubservice) {
  if (selectedSubservice != null) {
    // Do something with the selected subservice
  }
},
    );
  }
}