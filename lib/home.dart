import 'package:adminsite/api_php.dart';
import 'package:flutter/material.dart' as material;
import 'login.dart';
import 'audio/ilocaaudio.dart';
import 'package:adminsite/dashboar.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
import 'quiz.dart';
import 'translate/translation.dart';
import 'audio/pangaudio.dart';
import 'style/colorpallete.dart';
class Home extends StatefulWidget {
  const Home({
    Key? key,
    this.token,
  }) : super(key: key);
  final String? token;

  @override
  State<Home> createState() => _HomeState();
}
Future<int> me = fetchNotificationCount();
class _HomeState extends State<Home> {
  SharedPreferences? prefs;
bool ops = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      final savedToken = prefs.getString('token');
      if (savedToken != null) {}});
fetchNotificationCount;
  }
  void clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('token'); 
}

void onLogoutButtonPressed() {

 Navigator.pushReplacement(
          context,
          FluentPageRoute(builder: (context) => const Login()));
}

void ppo() {
  setState(() {
    ops = !ops;
  });
}

PaneDisplayMode shes() {
  if (ops == true) {
    return PaneDisplayMode.open;
  } else {
    return PaneDisplayMode.compact;
  }
}


showLogout(){
 showDialog(
      context: context,
      builder: (context) {
        return material.AlertDialog(
          title: const Text('Logout'),
          content: const Text("Do you Really Want To Logout?"),
          actions: [
            material.TextButton(
              onPressed: () {
            Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            material.TextButton(
              onPressed: () {
                 Navigator.of(context).pop();
                onLogoutButtonPressed();
               clearToken();
              },
              child: const Text('Logout',style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),),
            ),
          ],
        );
      },
    );
}

int topIndex = 0;


List<NavigationPaneItem> items = [
  PaneItemHeader(header: const Text('Home',style: TextStyle(color: Comcol.dbl))),
    PaneItem(
      icon: Image.asset("assets/dashboard.png",cacheHeight: 15,width: 15,color:Comcol.dbl,),
      title: const Text('Dashboard' ,style: TextStyle(color: Comcol.dbl),),
      body: const DashB(),
    ),
    PaneItemSeparator(thickness: 2),
    PaneItem(
    title: const Text("Users" ,style: TextStyle(color: Comcol.dbl)), 
    body: const User(), icon: Image.asset("assets/Users.png",cacheHeight: 15,cacheWidth: 15,color: Comcol.dbl,)),
    PaneItemSeparator(thickness: 2),
    PaneItem(
      icon:Image.asset("assets/translate.png",cacheHeight: 15,cacheWidth: 15,color: Comcol.dbl,),
      title: const Text('Translation And Dictionary' ,style: TextStyle(color: Comcol.dbl)),
      body: const Translation(),   
    ),
    PaneItemSeparator(thickness: 2),
    PaneItemExpander(
      title: const Text('Audio' ,style: TextStyle(color: Comcol.dbl)),
      icon: Image.asset("assets/Audio.png",cacheHeight: 15,width: 10,color: Comcol.dbl,), 
      items: [PaneItem(
      icon: Container(),
      title: const Text('Ilocano Audio' ,style: TextStyle(color: Comcol.dbl)),
      body: const AudioIlocanoList(),  
    ),
    PaneItem(
      icon:Container(),
      title: const Text('Pangasinan Audio' ,style: TextStyle(color: Comcol.dbl)),
      body: const AudioPangasinanList(),  
    ),], 
      body: const NavigationView(
      content:AudioIlocanoList())),
    PaneItemSeparator(thickness: 2),
     PaneItem(icon: Image.asset("assets/Quiz.png",cacheHeight: 15,width: 15, color: Comcol.dbl,),
     title: const Text('Quiz' ,style: TextStyle(color: Comcol.dbl)), body: const QuizEasyList()),
    PaneItemSeparator(thickness: 2),
   
  PaneItemSeparator(),
  
  ];
  FlyoutController controller = FlyoutController();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Color g = const Color.fromRGBO(0, 0, 0, 0.0);
  @override
  Widget build(BuildContext context) {
    return 
    FluentApp(
         debugShowCheckedModeBanner: false, 
      theme: FluentThemeData(
        iconTheme: const IconThemeData(color:Comcol.dbl),
        navigationPaneTheme: const NavigationPaneThemeData(backgroundColor: Comcol.db1,
        )),
      home:  
      material.RefreshIndicator( onRefresh: () async { setState(() {
        me =fetchNotificationCount();
      });  },
      child: NavigationView( 
      appBar: NavigationAppBar(
        height: 80,
         title:   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Image.asset("assets/frolo.png",scale: 1,color: Comcol.dbl,),
          Image.asset("assets/midlo.png",color: Comcol.dbl,),FlyoutTarget(
    controller: controller,
    child: IconButton(
        icon: const Icon(FluentIcons.account_management, size: 40,color: Comcol.dbl,) ,
        onPressed: () {
            controller.showFlyout(
                autoModeConfiguration: FlyoutAutoConfiguration(
                    preferredMode: FlyoutPlacementMode.topCenter,
                ),
                barrierDismissible: true,
                dismissOnPointerMoveAway: false,
                dismissWithEsc: true,
                navigatorKey: navigatorKey.currentState,
                builder: (context) {
                    return FlyoutContent(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const Text(
                                    'User..',
                                    style: TextStyle(fontWeight: FontWeight.bold,color: Comcol.dbl),
                                ),
                                const SizedBox(height: 12.0),
                                Button(
                                    onPressed: showLogout,
                                    child: const Text('Logout',style: TextStyle(color: Comcol.dbl),),
                                ),
                            ],
                        ),
                    );
                },
            );
        },
    )
)
          ],) ,automaticallyImplyLeading: false),
    pane: NavigationPane(
    menuButton: IconButton(icon: const Icon( FluentIcons.context_menu), onPressed: () {ppo();},),
      size: const NavigationPaneSize(
        openMaxWidth: 250,
        compactWidth: 60,
        openWidth: 250
      ),
      indicator: const StickyNavigationIndicator( curve: Curves.linear,
   color: Comcol.dbl,
  duration: kIndicatorAnimationDuration,
   topPadding: 12.0,
   leftPadding: kPaneItemMinHeight * 0.3,
   indicatorSize: 2.75,),
     selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
      displayMode: shes(),
      items: items,
    )))
     );
}
}

Future<int> fetchNotificationCount() async {
  final response = await http.get(Uri.parse(Api.notif));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final totalRecords = data['totalRecords'] as int;
    return totalRecords;
  } else {
    throw Exception('Failed to load data');
  }
}
