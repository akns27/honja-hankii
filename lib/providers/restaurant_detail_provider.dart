import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';
import './restaurant_provider.dart';

// 선택된 식당의 상세 정보를 가져오는 provider
final restaurantDetailProvider =
    FutureProvider.family<Restaurant?, int>((ref, id) async {
  final repository = ref.read(restaurantRepositoryProvider);
  return repository.getRestaurant(id);
});
