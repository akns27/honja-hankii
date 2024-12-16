// import 'package:flutter/material.dart';
//
// class RestaurantDetailScreen extends StatelessWidget {
//   final int restaurantId;
//
//   const RestaurantDetailScreen({
//     super.key,
//     required this.restaurantId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // 상단 이미지와 앱바
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 color: Colors.grey[300],
//                 child: const Center(
//                   child: Icon(Icons.restaurant, size: 100, color: Colors.grey),
//                 ),
//               ),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.favorite_border),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//
//           // 식당 정보
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 식당 이름과 평점
//                   Row(
//                     children: [
//                       const Expanded(
//                         child: Text(
//                           '식당 이름',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber, size: 20),
//                           const SizedBox(width: 4),
//                           const Text(
//                             '4.2',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             ' (12개)',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//
//                   // 주소
//                   Row(
//                     children: [
//                       Icon(Icons.location_on_outlined, color: Colors.grey[600]),
//                       const SizedBox(width: 8),
//                       Text(
//                         '서울시 강남구 역삼동 123-45',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//
//                   // 1인석 여부, Wi-Fi, 콘센트
//                   const Text(
//                     '시설 정보',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _buildFacilityInfo(Icons.chair_outlined, '1인석 있음'),
//                       const SizedBox(width: 16),
//                       _buildFacilityInfo(Icons.wifi, 'Wi-Fi 있음'),
//                       const SizedBox(width: 16),
//                       _buildFacilityInfo(Icons.power, '콘센트 있음'),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//
//                   // 메뉴
//                   const Text(
//                     '메뉴',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   _buildMenuItem('크림파스타', '16,000원'),
//                   _buildMenuItem('토마토파스타', '15,000원'),
//                   _buildMenuItem('까르보나라', '16,000원'),
//                   const SizedBox(height: 24),
//
//                   // 영업 시간
//                   const Text(
//                     '영업 시간',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     '월-금: 11:00 - 21:00\n토-일: 12:00 - 21:00',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[800],
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFacilityInfo(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: Colors.grey[700]),
//         const SizedBox(width: 4),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[700],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMenuItem(String name, String price) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(fontSize: 16),
//           ),
//           Text(
//             price,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/restaurant_detail_provider.dart';
import '../../providers/restaurant_provider.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final int restaurantId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(restaurantDetailProvider(restaurantId));

    return Scaffold(
      body: restaurantAsync.when(
        data: (restaurant) {
          if (restaurant == null) {
            return const Center(child: Text('식당 정보를 찾을 수 없습니다.'));
          }

          return CustomScrollView(
            slivers: [
              // 상단 이미지와 앱바
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    child: restaurant.imageUrl != null
                        ? Image.asset(
                            'assets/images/restaurant/${restaurant.imageUrl}',
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.restaurant,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  Consumer(
                    builder: (context, ref, _) {
                      final favorites = ref.watch(favoritesProvider);
                      final isFavorite = favorites.contains(restaurantId);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(restaurantId);
                        },
                      );
                    },
                  ),
                ],
              ),

              // 식당 정보
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 식당 이름과 평점
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // 주소
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              restaurant.address,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 편의 시설
                      const Text(
                        '시설 정보',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          if (restaurant.hasSingleTable)
                            _buildFacilityInfo(Icons.chair_outlined, '1인석 있음'),
                          if (restaurant.hasWifi) ...[
                            const SizedBox(width: 16),
                            _buildFacilityInfo(Icons.wifi, 'Wi-Fi 있음'),
                          ],
                          if (restaurant.hasSocket) ...[
                            const SizedBox(width: 16),
                            _buildFacilityInfo(Icons.power, '콘센트 있음'),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 영업 시간
                      const Text(
                        '영업 시간',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        restaurant.openingHours,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                      // 메뉴 섹션
                      if (restaurant.menuItems != null &&
                          restaurant.menuItems!.isNotEmpty) ...[
                        const Text(
                          '대표 메뉴',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurant.menuItems!.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final menu = restaurant.menuItems![index];
                            return Row(
                              children: [
                                // 메뉴 이미지
                                if (menu.imageUrl != null)
                                  Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/restaurant/${menu.imageUrl}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                // 메뉴 정보
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        menu.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${menu.price}원',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('오류가 발생했습니다: $error'),
        ),
      ),
    );
  }

  Widget _buildFacilityInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
