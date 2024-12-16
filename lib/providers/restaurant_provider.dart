import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

// RestaurantRepository Provider
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository();
});

// 더미 데이터 생성
final List<Restaurant> _dummyRestaurants = [
  Restaurant(
      id: 1,
      name: '맛있는 식당',
      category: '한식',
      address: '서울시 강남구',
      rating: 4.5,
      imageUrl: null, // 테스트용이라 이미지는 없음
      hasSingleTable: true,
      hasSocket: true,
      hasWifi: false,
      openingHours: '8시'),
  Restaurant(
      id: 2,
      name: '행복한 분식',
      category: '분식',
      address: '서울시 강남구',
      rating: 4.2,
      imageUrl: null,
      hasSingleTable: true,
      hasSocket: true,
      hasWifi: false,
      openingHours: '8시'),
  Restaurant(
      id: 3,
      name: '맛있는 라멘',
      category: '일식',
      address: '서울시 강남구',
      rating: 4.7,
      imageUrl: null,
      hasSingleTable: false,
      hasSocket: true,
      hasWifi: false,
      openingHours: '8시'),
];

// 모든 식당 목록을 관리하는 Provider
final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final repository = ref.read(restaurantRepositoryProvider);
  return repository.getAllRestaurants();
});

// 선택된 카테고리를 관리하는 Provider
final selectedCategoryProvider = StateProvider<String>((ref) => '전체');

// 필터링된 식당 목록을 제공하는 Provider
final filteredRestaurantsProvider =
    Provider<AsyncValue<List<Restaurant>>>((ref) {
  final restaurants = ref.watch(restaurantsProvider);
  final category = ref.watch(selectedCategoryProvider);

  return restaurants.when(
    data: (list) {
      if (category == '전체') return AsyncValue.data(list);
      return AsyncValue.data(
        list.where((restaurant) => restaurant.category == category).toList(),
      );
    },
    loading: () => const AsyncValue.loading(),
    error: (err, stack) => AsyncValue.error(err, stack),
  );
});

// 즐겨찾기 상태를 관리하는 Provider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});

// 즐겨찾기 상태 관리 클래스
class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(int restaurantId) {
    if (state.contains(restaurantId)) {
      state = state.where((id) => id != restaurantId).toList();
    } else {
      state = [...state, restaurantId];
    }
  }
}
