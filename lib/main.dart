import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'login.dart';
import 'home.dart';
import 'api_php.dart';
import 'dart:ui';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hasToken = await checkToken();

  // Retrieve or detect the local IP address
  String localIp = await getOrDetectLocalIpAddress();

  // Pass the IP address to the Api class
  Api.setLocalIp(localIp);

  PlatformDispatcher.instance.views.first.physicalSize;

  PlatformDispatcher.instance.views
      .map((v) => v.physicalSize)
      .reduce((curr, next) =>
          curr.width * curr.height > next.width * next.height ? curr : next);

  await windowManager.setFullScreen(true);
  await windowManager.isMaximized();
  await windowManager.show();

  runApp(FluentApp(
    debugShowCheckedModeBanner: false,
    home: hasToken ? const Home() : const LoginPage(),
  ));
}

Future<bool> checkToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null;
}

Future<String> getOrDetectLocalIpAddress() async {
  final prefs = await SharedPreferences.getInstance();
  String? localIp = prefs.getString('local_ip');

  if (localIp == null) {
    localIp = await detectLocalIpAddress();
    await prefs.setString('local_ip', localIp);
  }

  return localIp;
}

Future<String> detectLocalIpAddress() async {
  try {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
  } catch (e) {
    return 'Failed to get IP address';
  }
  return 'Unknown';
}
