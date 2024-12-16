import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../restaurant/restaurant_detail_screen.dart';

// 먼저 바텀 시트 위젯을 따로 만들어줍니다
class RestaurantBottomSheet extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantBottomSheet({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 식당 이미지
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
          const SizedBox(height: 16),

          // 식당 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 카테고리와 주소
          Text(
            restaurant.category,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            restaurant.address,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),

          // 시설 정보
          Row(
            children: [
              if (restaurant.hasSingleTable)
                _buildFacilityInfo(Icons.chair_outlined, '1인석'),
              if (restaurant.hasWifi) ...[
                const SizedBox(width: 16),
                _buildFacilityInfo(Icons.wifi, 'Wi-Fi'),
              ],
              if (restaurant.hasSocket) ...[
                const SizedBox(width: 16),
                _buildFacilityInfo(Icons.power, '콘센트'),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // 상세 보기 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailScreen(
                      restaurantId: restaurant.id!,
                    ),
                  ),
                );
              },
              child: const Text('상세 보기'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
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
