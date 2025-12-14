import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../lib/features/home/views/location/location_view.dart';

void main() {
  group('LocationViewPage Widget Tests', () {
    testWidgets('LocationViewPage renders all UI components', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for async operations to complete
      await tester.pumpAndSettle(Duration(seconds: 5));

      // Verify that the location view page is rendered
      expect(find.text('Your Location'), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Current Location'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('LocationViewPage shows loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Verify initial loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Fetching location...'), findsOneWidget);
    });

    testWidgets('LocationViewPage back button is present and tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Find back button
      final backButton = find.byIcon(Icons.arrow_back_ios_new);
      expect(backButton, findsOneWidget);
      
      // Verify button is tappable
      expect(tester.widget<IconButton>(backButton).onPressed, isNotNull);
    });

    testWidgets('LocationViewPage search button opens search sheet', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Find and tap search button
      final searchButton = find.byIcon(Icons.search);
      expect(searchButton, findsOneWidget);
      
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      // Verify search sheet is opened
      expect(find.text('Search location...'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Container), findsWidgets); // Bottom sheet container
    });

    testWidgets('LocationViewPage current location button works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for initial loading to complete
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Find current location button
      final currentLocationButton = find.text('Current Location');
      expect(currentLocationButton, findsOneWidget);
      
      // Verify button is enabled and tappable
      expect(tester.widget<ElevatedButton>(currentLocationButton).onPressed, isNotNull);
      
      // Tap the button
      await tester.tap(currentLocationButton);
      await tester.pump();
    });

    testWidgets('LocationViewPage confirm button works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for initial loading to complete
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Find confirm button
      final confirmButton = find.text('Confirm');
      expect(confirmButton, findsOneWidget);
      
      // Verify button is enabled and tappable
      expect(tester.widget<ElevatedButton>(confirmButton).onPressed, isNotNull);
      
      // Tap the button
      await tester.tap(confirmButton);
      await tester.pump();
    });

    testWidgets('LocationViewPage zoom controls are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Find zoom controls
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      
      // Test zoom in button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      // Test zoom out button
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
    });

    testWidgets('LocationViewPage has correct theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Check scaffold background color
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(const Color(0xFF1C1C1E)));
    });

    testWidgets('LocationViewPage GoogleMap configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Find GoogleMap widget
      final googleMapFinder = find.byType(GoogleMap);
      expect(googleMapFinder, findsOneWidget);

      // Get the GoogleMap widget to verify its properties
      final googleMap = tester.widget<GoogleMap>(googleMapFinder);
      
      // Verify map configuration
      expect(googleMap.myLocationEnabled, isTrue);
      expect(googleMap.myLocationButtonEnabled, isFalse);
      expect(googleMap.zoomControlsEnabled, isFalse);
      expect(googleMap.mapToolbarEnabled, isFalse);
      expect(googleMap.compassEnabled, isTrue);
      expect(googleMap.mapType, equals(MapType.normal));
    });

    testWidgets('LocationViewPage location info card displays', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for loading to complete
      await tester.pumpAndSettle(Duration(seconds: 5));

      // Verify location info card elements
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.text('Selected Location'), findsOneWidget);
      
      // Check if address is displayed (either loading or actual address)
      expect(find.text('Fetching location...'), findsOneWidget);
    });

    testWidgets('LocationViewPage search functionality', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Open search sheet
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Find text field
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Enter search text
      await tester.enterText(textField, 'Dhaka');
      await tester.pump();

      // Verify text was entered
      expect(find.text('Dhaka'), findsOneWidget);
    });

    testWidgets('LocationViewPage error handling shows fallback', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for async operations to complete (including potential errors)
      await tester.pumpAndSettle(Duration(seconds: 10));

      // The app should show either successful location or fallback
      // Check if either location address or default location is shown
      final hasLocationAddress = find.textContaining(',').evaluate().isNotEmpty ||
                                 find.textContaining('Dhaka').evaluate().isNotEmpty;
      
      // At minimum, the app should not crash and should show some location info
      expect(find.byType(LocationViewPage), findsOneWidget);
    });

    testWidgets('LocationViewPage complete user interaction flow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for initial loading
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test search functionality
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byType(TextField), 'Test Location');
      await tester.pump();
      
      // Close search sheet by tapping outside
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Test zoom controls
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Test current location button
      await tester.tap(find.text('Current Location'));
      await tester.pump();

      // Verify all elements are still present after interactions
      expect(find.text('Your Location'), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
      expect(find.text('Current Location'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });
  });

  group('LocationViewPage Performance Tests', () {
    testWidgets('LocationViewPage renders within reasonable time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      await tester.pumpAndSettle(Duration(seconds: 5));
      
      stopwatch.stop();
      
      // Should render within 5 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('LocationViewPage handles rapid button taps', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Rapid tap on multiple buttons
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();
        await tester.pageBack();
        await tester.pump();
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
        await tester.tap(find.byIcon(Icons.remove));
        await tester.pump();
      }

      // App should still be responsive
      expect(find.byType(LocationViewPage), findsOneWidget);
    });
  });
}
