import '../database/database_helper.dart';
import '../models/restaurant.dart';

class RestaurantRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // 식당 추가
  Future<int> insertRestaurant(Restaurant restaurant) async {
    final db = await _databaseHelper.database;
    return await db.insert('restaurants', restaurant.toMap());
  }

  // 모든 식당 가져오기
  Future<List<Restaurant>> getAllRestaurants() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('restaurants');
    return List.generate(maps.length, (i) {
      return Restaurant.fromMap(maps[i]);
    });
  }

  // 특정 식당 가져오기
  Future<Restaurant?> getRestaurant(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Restaurant.fromMap(maps.first);
    }
    return null;
  }

  // 식당 업데이트
  Future<int> updateRestaurant(Restaurant restaurant) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'restaurants',
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  // 식당 삭제
  Future<int> deleteRestaurant(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
