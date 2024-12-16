import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

// RestaurantRepository Provider
final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository();
});

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
