import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/routing.dart';
import 'app/home/route/lending_route.dart';
import 'utils/utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'EmployeeApp',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          useMaterial3: true,
            primarySwatch: Colors.red,
           scaffoldBackgroundColor: Colors.white,
            backgroundColor: kAppBarBackgroundColor,
            primaryColor: kPrimaryColor,
            fontFamily: kRegularFonts,
            snackBarTheme: SnackBarThemeData(
              actionTextColor: Colors.red,
            )
           ),
        color: kPrimaryColor,
        initialRoute: HomeRouting.route,
        routes: Routes().routes,
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);

          double scaleFactor = 1.0;

          if(data.textScaleFactor < 0.8) {
            scaleFactor = 0.8;
          } else if(data.textScaleFactor > 1.5) {
            scaleFactor = 1.2;
          }

          return MediaQuery(
            data: data.copyWith(
                textScaleFactor: scaleFactor
            ),
            child: child ?? Container(),
          );
        },
      );
    });
  }
}
