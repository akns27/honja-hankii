// import 'package:flutter/material.dart';
//
// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 상단 타이틀
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 '즐겨찾기',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             // 즐겨찾기 리스트
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: 10, // 임시 데이터 개수
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // 식당 이미지
//                         Stack(
//                           children: [
//                             Container(
//                               height: 200,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(4),
//                                 ),
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                       'assets/images/food_placeholder.jpg'),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             // 즐겨찾기 버튼 (이미 즐겨찾기된 상태)
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: IconButton(
//                                 icon: const Icon(
//                                   Icons.favorite,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () {
//                                   // 즐겨찾기 제거 기능 구현
//                                 },
//                                 style: IconButton.styleFrom(
//                                   backgroundColor: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         // 식당 정보
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 '식당 이름',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.star,
//                                     size: 16,
//                                     color: Colors.amber,
//                                   ),
//                                   const Text(
//                                     ' 4.2',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '음식 분야',
//                                     style: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '지역',
//                                     style: TextStyle(
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 '12,000원~25,000원',
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
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
import '../restaurant/restaurant_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 타이틀
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '즐겨찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 즐겨찾기 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailScreen(
                            restaurantId: index,
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
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                  color: Colors.grey[200],
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
                              ),
                              // 즐겨찾기 버튼
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // 즐겨찾기 제거 기능 구현
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // 식당 정보
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '식당 이름',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const Text(
                                      ' 4.2',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '음식 분야',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '지역',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '12,000원~25,000원',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
