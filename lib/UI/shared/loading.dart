import 'package:flutter/material.dart';
import 'package:mrfixit/app/auth_widget.dart';
import 'package:mrfixit/app/auth_widget_builder.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot){
        return AuthWidget(userSnapshot: userSnapshot);
      }),
    );
  }
}