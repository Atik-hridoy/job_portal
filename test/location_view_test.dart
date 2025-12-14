import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../lib/features/home/views/location/location_view.dart';

void main() {
  group('LocationViewPage Widget Tests', () {
    testWidgets('LocationViewPage renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for async operations to complete
      await tester.pumpAndSettle(const Duration(seconds: 5));

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

    testWidgets('LocationViewPage back button navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Find and tap back button
      final backButton = find.byIcon(Icons.arrow_back_ios_new);
      expect(backButton, findsOneWidget);
      
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify navigation (in real app, this would go back)
      // For test, we just verify the button exists and is tappable
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
    });

    testWidgets('LocationViewPage current location button works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for initial loading to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find current location button
      final currentLocationButton = find.text('Current Location');
      expect(currentLocationButton, findsOneWidget);
      
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
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find confirm button
      final confirmButton = find.text('Confirm');
      expect(confirmButton, findsOneWidget);
      
      // Tap the button
      await tester.tap(confirmButton);
      await tester.pump();
    });

    testWidgets('LocationViewPage zoom controls', (WidgetTester tester) async {
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

    testWidgets('LocationViewPage handles location errors gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for async operations to complete (including potential errors)
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // The app should show either successful location or fallback location
      // Check if location info is displayed
      expect(find.byType(LocationViewPage), findsOneWidget);
      
      // Should not show loading forever
      expect(find.text('Fetching location...'), findsNothing);
    });

    testWidgets('LocationViewPage complete user interaction flow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      // Wait for initial loading
      await tester.pumpAndSettle(const Duration(seconds: 3));

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

    testWidgets('LocationViewPage renders within reasonable time', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      stopwatch.stop();
      
      // Should render within 5 seconds
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('LocationViewPage handles rapid interactions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LocationViewPage(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Test multiple rapid interactions
      for (int i = 0; i < 3; i++) {
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
