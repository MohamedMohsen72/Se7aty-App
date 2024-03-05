import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/features/Booking/presentation/booking_view.dart';
import 'package:se7ety/features/Search/presentation/view/search_view.dart';
import 'package:se7ety/features/patient/presentation/view/home_view.dart';
import 'package:se7ety/features/profile/presentation/view/profile_view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  User? user;

  int _selectedIndex = 0;

  Future<void> getuser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  List page = [HomeView(),
    SearchView(),
    BookingView(),
    profileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColor.whiteColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: AppColor.primarycolor,
              color: Colors.black,
              tabs: [
                GButton(
                  iconSize: 30,
                  icon: Icons.home,
                  text: 'الرئيسيه',
                ),
                GButton(
                  iconSize: 30,
                  icon: Icons.search,
                  text: 'البحث',
                ),
                GButton(
                  iconSize: 30,
                  icon: Icons.calendar_month_rounded,
                  text: 'المواعيد',
                ),
                GButton(
                  iconSize: 30,
                  icon: Icons.person,
                  text: 'الحساب',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
