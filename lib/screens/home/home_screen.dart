// import 'package:flutter/material.dart';
// import '../restaurant/restaurant_detail_screen.dart';
// import '../search/search_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 상단 검색바 (클릭 시 검색 화면으로 이동)
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SearchScreen()),
//                 );
//               },
//               child: Container(
//                 margin: const EdgeInsets.all(16),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.blue,
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         '맛집을 검색해보세요',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     Icon(Icons.search, color: Colors.grey[600]),
//                   ],
//                 ),
//               ),
//             ),
//
//             // 주변 혼밥하기 좋은 장소 텍스트
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 '주변 혼밥하기 좋은 장소',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             // 식당 리스트
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const RestaurantDetailScreen(),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // 식당 이미지
//                           Container(
//                             height: 200,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(4),
//                               ),
//                               color: Colors.grey[200],
//                             ),
//                             child: Icon(
//                               Icons.restaurant,
//                               size: 50,
//                               color: Colors.grey[400],
//                             ),
//                           ),
//                           // 식당 정보
//                           Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Expanded(
//                                       child: Text(
//                                         '식당 이름',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.favorite_border),
//                                       onPressed: () {},
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.star,
//                                       size: 16,
//                                       color: Colors.amber,
//                                     ),
//                                     const Text(
//                                       ' 4.2',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       '음식 분야',
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       '지역',
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../restaurant/restaurant_detail_screen.dart';
import '../search/search_screen.dart';
import '../../providers/restaurant_provider.dart';

// ConsumerWidget으로 변경하여 Riverpod 사용
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 식당 데이터 가져오기
    final restaurantsAsync = ref.watch(restaurantsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 검색바 (클릭 시 검색 화면으로 이동)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '맛집을 검색해보세요',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),

            // 주변 혼밥하기 좋은 장소 텍스트
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '주변 혼밥하기 좋은 장소',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 식당 리스트 - 데이터 상태에 따른 처리
            Expanded(
              child: restaurantsAsync.when(
                data: (restaurants) {
                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text('주변에 등록된 식당이 없습니다.'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailScreen(
                                restaurantId: restaurant.id!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 식당 이미지
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                                child: restaurant.imageUrl != null
                                    ? Image.asset(
                                        'assets/images/restaurant/${restaurant.imageUrl}',
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.restaurant,
                                        size: 50,
                                        color: Colors.grey[400],
                                      ),
                              ),
                              // 식당 정보
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            restaurant.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Consumer(
                                          builder: (context, ref, _) {
                                            final favorites =
                                                ref.watch(favoritesProvider);
                                            final isFavorite = favorites
                                                .contains(restaurant.id);
                                            return IconButton(
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFavorite
                                                    ? Colors.red
                                                    : null,
                                              ),
                                              onPressed: () {
                                                ref
                                                    .read(favoritesProvider
                                                        .notifier)
                                                    .toggleFavorite(
                                                        restaurant.id!);
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          ' ${restaurant.rating}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          restaurant.category,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            restaurant.address,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('오류가 발생했습니다: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
