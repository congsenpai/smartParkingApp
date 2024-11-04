import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: WalletSection(),
                  ),
                  // Expanded(
                  //   child: SettingsSection(),
                  // ),
                ],
              ),
            ),
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Setting',
                ),
              ],
              currentIndex: 2,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class WalletSection extends StatefulWidget {
  @override
  State<WalletSection> createState() => _WalletSectionState();
}

class _WalletSectionState extends State<WalletSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Get.width/20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Wallet',
                style: TextStyle(fontSize: Get.width/20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.settings),
            ],
          ),
          SizedBox(height: Get.width/20),
          Container(
            width: Get.width/1.1,
            height: Get.height/6,
            padding: EdgeInsets.all(Get.width/20),
            decoration: BoxDecoration(
              color: Colors.indigo[900],
              borderRadius: BorderRadius.circular(Get.width/20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$7,409,332',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width/15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Angga Risky', style: TextStyle(color: Colors.white)),
                Text('2208 1996 4900', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                TransactionItem(
                  icon: Icons.location_on,
                  title: 'Angga Big Park',
                  subtitle: '10 hours ago • \$49.509',
                  date: '12 January 2024',
                  iconColor: Colors.blue,
                ),
                TransactionItem(
                  icon: Icons.account_balance_wallet,
                  title: 'Top Up',
                  subtitle: '10 hours ago • \$49.509',
                  date: '12 January 2024',
                  iconColor: Colors.green,
                ),
                TransactionItem(
                  icon: Icons.location_on,
                  title: 'Angga Big Park',
                  subtitle: '10 hours ago • \$49.509',
                  date: '12 January 2024',
                  iconColor: Colors.blue,
                ),
                TransactionItem(
                  icon: Icons.location_on,
                  title: 'Angga Big Park',
                  subtitle: '10 hours ago • \$49.509',
                  date: '12 January 2024',
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  final Color iconColor;

  TransactionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.iconColor,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(widget.icon, color: widget.iconColor),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                widget.date,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatefulWidget {
  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, size: 40, color: Colors.blue),
          ),
          SizedBox(height: 16),
          Text(
            '6281092102910',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                SettingsItem(
                  icon: Icons.person,
                  title: 'Edit Profile',
                ),
                SettingsItem(
                  icon: Icons.language,
                  title: 'App Language',
                ),
                SettingsItem(
                  icon: Icons.account_balance_wallet,
                  title: 'My Wallet',
                ),
                SettingsItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                ),
                SettingsItem(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                SettingsItem(
                  icon: Icons.help,
                  title: 'Contact & Help',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue),
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (trailing != null) trailing!,
          if (trailing == null) Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}