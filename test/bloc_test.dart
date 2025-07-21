import 'package:code_task/bloc/recipes_bloc.dart';
import 'package:code_task/bloc/recipes_state.dart';
import 'package:code_task/model/recipes_model.dart';
import 'package:code_task/screen/recipes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  testWidgets('UserScreen displays user info when state is UserLoaded',
          (WidgetTester tester) async {
        final user = UserModel(
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+91 9876543210',
          icon: '',
        );

        // Fake Bloc that immediately emits UserLoaded
        final userBloc = UserBloc()
          ..emit(UserLoaded(user)); // Push state directly for widget test

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<UserBloc>.value(
              value: userBloc,
              child: const UserScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('john@example.com'), findsOneWidget);
        expect(find.text('+91 9876543210'), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);
      });
}
