import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veeboss/Contants/Colors.dart';
import 'package:veeboss/Screens/AboutUs.dart';
import 'package:veeboss/Screens/ContactUs.dart';
import 'package:veeboss/Screens/LoginScreen.dart';

import 'CMSPage.dart';
import 'Employee/PdfViewr.dart';
import 'InvitePage.dart';
import 'MyPdfViewer.dart';
import 'WelcomeScreen.dart';
import 'agent/CreateJobAgent.dart';


class AppDrawer extends StatefulWidget {
  BuildContext context;
  AppDrawer(this.context);

  @override
  _AppDrawerPageState createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawer> {
  late SharedPreferences prefs;
  bool isVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: appBackground,
      child: ListView(
        padding: EdgeInsets.only(top: 45.0),
        children: <Widget>[
          //  _createHeader(),
          /* ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'HomePage',
                    style: TextStyle(
                        fontFamily: 'Opensans',
                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),*/


          /*   ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.wallet,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Wallet',
                    style: TextStyle(
                        fontFamily: 'Opensans',
                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {
              *//*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WalletPage();
                  },
                ),
              );*//*
            },
          ),*/

          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: appButton,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                        fontFamily: 'railway',
                        color: appText,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  AboutUs("About Us");
                      //MyPdfViewer(pdfPath:'assets/file/aboutus.pdf',);
                  },
                ),
              );*/

         //   _launchaboutus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AboutUs("About Us");
                  },
                ),
              );
            },
          ),

          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.contact_page_outlined,
                  color: appButton,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontFamily: 'railway',
                        color: appText,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ContactUs("Contact Us");
                  },
                ),
              );
            },
          ),

          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.person_add_alt,
                  color: appButton,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Invites',
                    style: TextStyle(
                        fontFamily: 'railway',
                        color: appText,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InvitePage("Veeboss");
                  },
                ),
              );
            },
          ),

          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.support,
                  color: appButton,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Support',
                    style: TextStyle(
                        fontFamily: 'Opensans',
                        color: appText,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            onTap: () {
              _launchWhatsapp();
            /*  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CMSPage("Policy");
                  },
                ),
              );*/
            },
          ),

           /*  ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.info,
                  color: appButton,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        fontFamily: 'Opensans',
                        color: appText,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            onTap: () {
              _launchtermsCondition();
            },
          ),*/


          Divider(),

          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
          ),


          SizedBox(
            height: size.height * 0.050,
          ),

          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _launchLinkedin();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Image(
                      image: AssetImage("assets/images/linkedin.png"),
                      height: size.height * 0.050,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchInstagram();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Image(
                      image: AssetImage("assets/images/instagram.png"),
                      height: size.height * 0.050,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchFacebook();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Image(
                      image: AssetImage("assets/images/facebook.png"),
                      height: size.height * 0.050,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchTwitter();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Image(
                      image: AssetImage("assets/images/twit.png"),
                      height: size.height * 0.040,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {

            },
          ),

          /*ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),*/
        ],
      ),
    );
  }

  Future<void> _launchWhatsapp() async {
    var whatsapp = "+91 99861 23413";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text= I am facing some problem, kindly help.");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  Future<void> _launchInstagram() async {
    String nativeUrl = "https://www.instagram.com/jobs_veebosstechnology/?igshid=MzNlNGNkZWQ4Mg%3D%3D";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  Future<void> _launchFacebook() async {
    String nativeUrl = "https://www.facebook.com/profile.php?id=100094254919077&mibextid=ZbWKwL";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Facebook is not installed on the device"),
        ),
      );
    }
  }

  Future<void> _launchLinkedin() async {
    String nativeUrl = "https://www.linkedin.com/in/veeboss-technology-098789281";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Linked In is not installed on the device"),
        ),
      );
    }
  }

  Future<void> _launchTwitter() async {
    String nativeUrl = "https://twitter.com/Veeboss_jobs?t=z2M7mFIaqARhkiZI6TyP3w&s=09";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Twitter is not installed on the device"),
        ),
      );
    }
  }

  Future<void> _launchaboutus() async {
    String nativeUrl = "https://yourang.shop/veeboss/public/aboutus";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("About Us"),
        ),
      );
    }
  }

  Future<void> _launchtermsCondition() async {
    String nativeUrl = "https://yourang.shop/veeboss/public/terms_codition";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terms Codition"),
        ),
      );
    }
  }


  Widget _createDrawerItem({required IconData icon, required String text}) {
    return ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: appButton,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: 'Opensans',
                    color: appText,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        onTap: () {
          if (prefs != null || prefs != "null") {
            prefs.setBool('isLogging', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  LoginScreen("user")
              ),
            );
          }
        }


    );
  }

  Future<void> getPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
      await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}
