import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_tgo/controllers/auth_provider_controller.dart';
import 'package:machine_test_tgo/models/auth_cred.dart';
import 'package:machine_test_tgo/services/firebase_auth_services.dart';
import 'package:machine_test_tgo/utils/size_utils/size_config.dart';
import 'package:machine_test_tgo/utils/theme/app_theme.dart';
import 'package:machine_test_tgo/utils/widgets/responsive_safe_area.dart';
import 'package:machine_test_tgo/views/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProviderController>(create: (_) => AuthProviderController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //

          primarySwatch: Colors.blue,
        ),
        home: const InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late final AuthProviderController authProviderController;
  late final User? user;

  @override
  void initState() {
    authProviderController = Provider.of(context, listen: false);
    storeUserCred();
    super.initState();
  }

  void storeUserCred() async {
    user = FirebaseAuthServices.firebaseAuth().currentUser;
    if (user != null) {
      final token = await user!.getIdToken();
      authProviderController.setAuthCred(AuthCred(userId: user!.uid, token: token));
    }
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? HomeScreen() : SIgnInScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ResponsiveSafeArea(builder: (context, size) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Home Screen",
                style: AppTheme.textThemes.headline3,
              ),
              Consumer<AuthProviderController>(
                builder: (context, provider, _) => Text("UserId ::: ${provider.userId}"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
