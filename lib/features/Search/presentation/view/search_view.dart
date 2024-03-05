import 'package:flutter/material.dart';
import 'package:se7ety/core/Utils/color.dart';
import 'package:se7ety/core/Utils/text_styles.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ابحث عن دكتور',
          style: getTextTitle(color: AppColor.whiteColor, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 12, color: AppColor.greyColor.withOpacity(0.4))
              ]),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'البحث ',
                  hintStyle: getTextbady(),
                  suffixIcon: Icon(Icons.search, size: 30),
                ),
              ),
              
            ),
            Spacer(flex: 1),
            Text(
              'عرض كل الدكاتره',
              style: getTextTitle(
                  color: AppColor.primarycolor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset('assets/no-search.png'),
            Spacer(flex: 1),
            
          ],
        ),
      ),
    );
  }
}
