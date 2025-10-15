import 'package:flowery_tracking_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/theme/colors.dart';
import '../../core/helpers/spacing.dart';
import '../../core/l10n/translations/app_localizations.dart';
import '../main_profile/presentation/pages/main_profile.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final List<Widget> pages = [
      Center(
        key: const Key('home_page'),
        child: Text(
          localization.home,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      Center(
        key: const Key('orders_page'),
        child: Text(
          localization.orders,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      const MainProfile(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildBottomNavigationBarItem(
            AppAssets.homeIcon,
            localization.home,
            0,
          ),
          _buildBottomNavigationBarItem(
            AppAssets.ordersIcon,
            localization.orders,
            1,
          ),
          _buildBottomNavigationBarItem(
            AppAssets.profileIcon,
            localization.profile,
            2,
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              _currentIndex == index ? AppColors.pink : AppColors.white[80]!,
              BlendMode.srcIn,
            ),
          ),
          verticalSpace(7),
        ],
      ),
      label: label,
    );
  }
}
