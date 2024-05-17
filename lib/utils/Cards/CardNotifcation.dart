import 'package:flutter/material.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class CardNotifcation extends StatefulWidget {
  final List<Map<String, dynamic>> notifications;
  final int index;

  const CardNotifcation({
    super.key,
    required this.notifications,
    required this.index,
  });

  @override
  _CardNotifcationState createState() => _CardNotifcationState();
}

class _CardNotifcationState extends State<CardNotifcation> {
  @override
  Widget build(BuildContext context) {
    var notifications = widget.notifications;
    var index = widget.index;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: notifications[index]["isRead"]
          ? Colors.white
          : Colors.lightBlueAccent[100],
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: AssetImage(notifications[index]["photo"]),
        ),
        title: Text(
          notifications[index]["name"],
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          notifications[index]["date"],
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Handle delete action
            setState(() {
              // Remove the notification from the list
              notifications.removeAt(index);
            });
          },
        ),
        onTap: () {
          // Handle notification tap
          // Mark notification as read
          setState(() {
            notifications[index]["isRead"] = true;
          });
        },
      ),
    );
  }
}
