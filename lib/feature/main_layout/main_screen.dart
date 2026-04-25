import 'package:exam_app/core/theme/app_theme.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/profile/presentation/screen/profile_screen.dart';
import 'package:exam_app/feature/result/presentation/screen/result_screen.dart';
import 'package:exam_app/feature/subject/presentation/screen/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/values/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SubjectScreen(),
    ResultScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _icons = [
    AppAssets.home,
    AppAssets.carbonResultDraft,
    AppAssets.person,
  ];
  final List<String> _label = [
    AppStrings.explore,
    AppStrings.results,
    AppStrings.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: AppTheme.lightTheme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: List<BottomNavigationBarItem>.generate(
            _widgetOptions.length,
            (index) => BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                decoration: _selectedIndex == index
                    ? BoxDecoration(
                        color: AppColors.blue10,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      )
                    : null,
                child: SvgPicture.asset(
                  _icons[index],
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryBlue,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: _label[index],
            ),
          ),
          currentIndex: _selectedIndex,
          unselectedLabelStyle: AppFontStyle.medium12(context),
          selectedLabelStyle: AppFontStyle.medium12(context),
          unselectedItemColor: AppColors.primaryBlue,
          elevation: 0,

          onTap: _onItemTapped,

          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
