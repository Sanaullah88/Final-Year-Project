import 'package:flutter/material.dart';

class PickupNotificationPage extends StatelessWidget {
  const PickupNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildNotificationItem(
            icon: Icons.info,
            title: 'New update available',
            subtitle: 'Version 2.0 is now available for download',
            date: 'May 5, 2023',
          ),
          _buildNotificationItem(
            icon: Icons.check_circle_outline,
            title: 'Order confirmed',
            subtitle: 'Your order #12345 has been confirmed',
            date: 'May 3, 2023',
          ),
          _buildNotificationItem(
            icon: Icons.warning,
            title: 'Payment failed',
            subtitle: 'Your payment for order #67890 has failed',
            date: 'May 1, 2023',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(date),
      onTap: () {
        // Handle notification tap here
      },
    );
  }
}
