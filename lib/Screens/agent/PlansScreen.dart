import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss/Models/Agent/Plans.dart';


class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans>
    with TickerProviderStateMixin {
  late PlansList plansList;
  List<PlansListItem> planListItems = [];
  late SharedPreferences prefs;
  bool idLoading = false;


  @override
  void initState() {

    super.initState();
    getAgentReferelUsers();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container());
  }


  Future<void> getAgentReferelUsers() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      idLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/plans/get',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken'),
    };

    Response response = await get(uri);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("SubCategoryList::$responseBody");
    if (statusCode == 200) {
      setState(() {
        idLoading = false;
        plansList = PlansList.fromJson(jsonDecode(responseBody));
        planListItems.addAll(plansList.data!);
      });
    }
  }
}


