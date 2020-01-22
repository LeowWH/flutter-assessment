import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

dateInputField(context, controller){
	return new TextField(
        onTap: (){
        	FocusScope.of(context).requestFocus(new FocusNode());
        	DatePicker.showDatePicker(context,
				showTitleActions: true,
				minTime: DateTime.now(),
				maxTime: DateTime.now().add(new Duration(days: 365)), 
				currentTime: controller.text.isEmpty?DateTime.now():DateTime.parse(controller.text),
				onConfirm: (chosen) {
					controller.text = formatDate(chosen, [yyyy, '-', mm, '-', dd]).toString();
			 	}, 
			);
        },
		controller: controller,
		decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
        contentPadding: const EdgeInsets.only(top:0.0,bottom:0.0, right: 5.0, left: 5.0),
        hintText: 'Select a date',
        suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down)
        ),
      ),
    );
}

