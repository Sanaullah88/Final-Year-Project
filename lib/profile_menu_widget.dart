import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';




class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor, 
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors: Colors.yellow;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: (iconColor as Color).withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.grey,),
      ),
      title: Text(
  title,
  style: TextStyle(
    fontSize: 18, // replace with desired font size
    color: textColor,
  ),
),


      trailing: endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
            
          ),
          child: const Icon(LineAwesomeIcons.angle_right, size: 30, color: Colors.red)) : null,
    );
  }
}