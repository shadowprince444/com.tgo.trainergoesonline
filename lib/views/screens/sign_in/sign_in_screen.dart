import 'package:flutter/material.dart';
import 'package:machine_test_tgo/controllers/auth_provider_controller.dart';
import 'package:machine_test_tgo/main.dart';
import 'package:machine_test_tgo/utils/size_utils/size_config.dart';
import 'package:machine_test_tgo/utils/theme/app_theme.dart';
import 'package:machine_test_tgo/utils/widgets/responsive_safe_area.dart';
import 'package:machine_test_tgo/utils/widgets/spacing_widgets.dart';
import 'package:provider/provider.dart';

class SIgnInScreen extends StatelessWidget {
  const SIgnInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _authProvider = Provider.of<AuthProviderController>(context, listen: false);
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) => SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final isSignedIn = await _authProvider.googleSignIn();
                  if (isSignedIn) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }
                },
                child: Text(
                  "Google Sign-in",
                  style: AppTheme.textThemes.headline2,
                ),
              ),
              const VSpace(20),
              Consumer<AuthProviderController>(builder: (context, provider, _) {
                return Visibility(
                  visible: provider.errorText?.isNotEmpty ?? false,
                  child: Text(
                    provider.errorText!,
                    style: AppTheme.textThemes.bodyText2,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
