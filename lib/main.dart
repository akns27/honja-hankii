import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/main_screen.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 데이터베이스 초기화 및 샘플 데이터 삽입
  await DatabaseHelper.instance.database;
  await DatabaseHelper.instance.insertSampleData();

//  lib/main.dart
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '혼자 한 끼',
      theme: ThemeData(
        // 기본 색상을 #54ACFF로 변경
        primaryColor: const Color(0xFF54ACFF),
        // Material3 디자인의 색상 시스템 설정
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54ACFF),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
