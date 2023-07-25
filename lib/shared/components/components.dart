import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic>route)=>false
);


Widget defaultFormField({
  required bool readonly,
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  Function? onTap, // Update the parameter name to onTap
  required String? Function(String?)? validate,
  required String label,
  required IconData icon,
  bool is_clickable=true,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) {
  return TextFormField(
    readOnly: readonly,
    controller: controller,
    keyboardType: type,
    enabled: is_clickable,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),

      suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix,),): null,
      border: const OutlineInputBorder(),
    ),
  );
}


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );



Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function, // Remove the parentheses here
      child: Text(
        text.toUpperCase(),
      ),
    );