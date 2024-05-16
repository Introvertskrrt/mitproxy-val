import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mitproxy_val/controllers/login_controller.dart';
import 'package:mitproxy_val/views/login_view.dart';

void main() {
  testWidgets('LoginView UI Test', (WidgetTester tester) async {
    // Initialize the LoginController
    Get.put(LoginController());

    // Build the LoginView and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginView(),
      ),
    );

    // Verify if the welcome text is present
    expect(find.text('Welcome\nSign-in With Riot Account'), findsOneWidget);

    // Verify if the username field is present
    expect(find.byType(TextFormField).at(0), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');

    // Verify if the password field is present and enter text
    expect(find.byType(TextFormField).at(1), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(1), 'testpassword');

    // Verify if the "Remember Me" checkbox is present and toggle it
    expect(find.byType(Checkbox), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verify if the "Submit" button is present and tap it
    expect(find.text('Submit'), findsOneWidget);
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // Verify if the "Privacy Policy" link is present
    expect(find.text('Privacy Policy'), findsOneWidget);

    // Verify the state changes in the controller after login button is clicked
    final loginController = Get.find<LoginController>();
    expect(loginController.username.text, 'testuser');
    expect(loginController.password.text, 'testpassword');
    expect(loginController.isRememberMe.value, true);
  });
}
