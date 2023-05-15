


import '../../const/const.dart';
import 'text_widget.dart';

Widget ourButton({title, color = purpleColor, onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
      onPressed: onPress, child: normalText(text: title,size: 16.0));
}