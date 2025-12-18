import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:job_portal/features/errors/views/error_gallery_view.dart';
import 'package:job_portal/features/errors/views/no_connection_error_view.dart';
import 'package:job_portal/features/errors/views/not_found_error_view.dart';
import 'package:job_portal/features/errors/views/server_error_view.dart';

void main() {
  Future<void> pumpWithMaterialApp(
    WidgetTester tester,
    Widget widget,
  ) async {
    await tester.pumpWidget(MaterialApp(home: widget));
  }

  group('NotFoundErrorView', () {
    testWidgets('renders headline and actions', (tester) async {
      await pumpWithMaterialApp(tester, const NotFoundErrorView());

      expect(find.text("We couldn't find that"), findsOneWidget);
      expect(find.text('Back to home'), findsOneWidget);
      expect(find.text('Report this issue'), findsOneWidget);
    });

    testWidgets('shows snackbar when reporting issue', (tester) async {
      await pumpWithMaterialApp(tester, const NotFoundErrorView());

      await tester.tap(find.text('Report this issue'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Issue reported.'), findsOneWidget);
    });
  });

  group('NoConnectionErrorView', () {
    testWidgets('renders proper content', (tester) async {
      await pumpWithMaterialApp(tester, const NoConnectionErrorView());

      expect(find.text("You're offline"), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.text('Open settings'), findsOneWidget);
    });

    testWidgets('shows retry snackbar on primary action', (tester) async {
      await pumpWithMaterialApp(tester, const NoConnectionErrorView());

      await tester.tap(find.text('Retry'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Retrying...'), findsOneWidget);
    });

    testWidgets('shows settings snackbar on secondary action', (tester) async {
      await pumpWithMaterialApp(tester, const NoConnectionErrorView());

      await tester.tap(find.text('Open settings'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Opening settings...'), findsOneWidget);
    });
  });

  group('ServerErrorView', () {
    testWidgets('shows expected headline and actions', (tester) async {
      await pumpWithMaterialApp(tester, const ServerErrorView());

      expect(find.text('Something broke on our side'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
      expect(find.text('Contact support'), findsOneWidget);
    });

    testWidgets('shows retry snackbar on primary action', (tester) async {
      await pumpWithMaterialApp(tester, const ServerErrorView());

      await tester.tap(find.text('Try again'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Retrying...'), findsOneWidget);
    });

    testWidgets('shows support snackbar on secondary action', (tester) async {
      await pumpWithMaterialApp(tester, const ServerErrorView());

      await tester.tap(find.text('Contact support'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Opening support chat...'), findsOneWidget);
    });
  });

  group('ErrorGalleryView', () {
    testWidgets('lists all error screen options', (tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: ErrorGalleryView()));

      expect(find.text('404 — Not Found'), findsOneWidget);
      expect(find.text('Offline — No Connection'), findsOneWidget);
      expect(find.text('500 — Server Error'), findsOneWidget);
    });

    testWidgets('navigates to not found view when tapped', (tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: ErrorGalleryView()));

      await tester.tap(find.text('404 — Not Found'));
      await tester.pumpAndSettle();

      expect(find.text("We couldn't find that"), findsOneWidget);
    });
  });
}
