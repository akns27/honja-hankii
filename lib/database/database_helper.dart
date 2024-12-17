import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database; //

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('honja_hanki.db'); // _initDB로 수정
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // _createDB로 수정
    // 식당 테이블 생성
    await db.execute('''
      CREATE TABLE restaurants(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        address TEXT NOT NULL,
        rating REAL NOT NULL,
        hasSingleTable INTEGER NOT NULL,
        hasWifi INTEGER NOT NULL,
        hasSocket INTEGER NOT NULL,
        openingHours TEXT NOT NULL,
        imageUrl TEXT
      )
    ''');

    // 즐겨찾기 테이블 생성
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        restaurantId INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // 사용자 테이블 생성
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        name TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  // 데이터베이스 닫기
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertSampleData() async {
    final db = await database;

    // 기존 데이터 삭제
    await db.delete('restaurants');

    // 샘플 식당 데이터
    final List<Map<String, dynamic>> sampleRestaurants = [
      {
        'name': '빌즈 강남',
        'category': '양식',
        'address': '서울시 강남구 역삼동 123-45',
        'rating': 4.5,
        'hasSingleTable': 1,
        'hasWifi': 1,
        'hasSocket': 1,
        'openingHours': '11:00-21:00',
        'imageUrl': 'bills_gangnam.jpeg',
      },
      {
        'name': '용용선생 논현점',
        'category': '중식',
        'address': '서울특별시 강남구 학동로2길 54',
        'rating': 4.6,
        'hasSingleTable': 0,
        'hasWifi': 1,
        'hasSocket': 0,
        'openingHours': '17:00-02:00',
        'imageUrl': 'yongyong.jpeg',
      },
      {
        'name': '주신당 강남역 강남점',
        'category': '한식',
        'address': '서울 강남구 강남대로96길 9',
        'rating': 4.3,
        'hasSingleTable': 0,
        'hasWifi': 1,
        'hasSocket': 1,
        'openingHours': '11:00-02:00',
        'imageUrl': 'jusindang.jpeg',
      },
      {
        'name': '진우림',
        'category': '한식',
        'address': '서울 강남구 언주로71길 5-10 1층',
        'rating': 4.9,
        'hasSingleTable': 1,
        'hasWifi': 0,
        'hasSocket': 1,
        'openingHours': '11:00-22:00',
        'imageUrl': 'jinwoorim.jpeg',
      },
      {
        'name': '카야루',
        'category': '일식',
        'address': '서울특별시 강남구 선릉로86길 5-4',
        'rating': 4.9,
        'hasSingleTable': 1,
        'hasWifi': 0,
        'hasSocket': 1,
        'openingHours': '17:00-03:00',
        'imageUrl': 'kayaroo.jpeg',
      },
      {
        'name': '징키스칸 슌',
        'category': '일식',
        'address': '서울특별시 강남구 테헤란로64길 13',
        'rating': 4.2,
        'hasSingleTable': 1,
        'hasWifi': 1,
        'hasSocket': 1,
        'openingHours': '17:00-03:00',
        'imageUrl': 'shun.jpeg',
      },
      {
        'name': '몽중헌 공덕점',
        'category': '중식',
        'address': '서울시 강남구 역삼동 234-56',
        'rating': 4.2,
        'hasSingleTable': 1,
        'hasWifi': 1,
        'hasSocket': 1,
        'openingHours': '11:30-20:30',
        'imageUrl': 'mongjungheon-gongduk.jpeg',
      },
      {
        'name': '미에뜨',
        'category': '양식',
        'address': '서울시 강남구 역삼동 345-67',
        'rating': 4.7,
        'hasSingleTable': 1,
        'hasWifi': 1,
        'hasSocket': 0,
        'openingHours': '10:30-21:30',
        'imageUrl': 'miette.jpeg',
      },
      {
        'name': '베타서비스',
        'category': '양식',
        'address': '서울시 강남구 역삼동 456-78',
        'rating': 4.3,
        'hasSingleTable': 1,
        'hasWifi': 1,
        'hasSocket': 1,
        'openingHours': '11:00-22:00',
        'imageUrl': 'beta-service.jpeg',
      },
    ];

    // 데이터 삽입
    for (var restaurant in sampleRestaurants) {
      await db.insert('restaurants', restaurant);
    }
  }
}
