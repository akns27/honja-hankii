import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final int restaurantId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 상단 이미지와 앱바
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.restaurant, size: 100, color: Colors.grey),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
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
                      const Expanded(
                        child: Text(
                          '식당 이름',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          const Text(
                            '4.2',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' (12개)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
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
                      Icon(Icons.location_on_outlined, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        '서울시 강남구 역삼동 123-45',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 1인석 여부, Wi-Fi, 콘센트
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
                      _buildFacilityInfo(Icons.chair_outlined, '1인석 있음'),
                      const SizedBox(width: 16),
                      _buildFacilityInfo(Icons.wifi, 'Wi-Fi 있음'),
                      const SizedBox(width: 16),
                      _buildFacilityInfo(Icons.power, '콘센트 있음'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 메뉴
                  const Text(
                    '메뉴',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem('크림파스타', '16,000원'),
                  _buildMenuItem('토마토파스타', '15,000원'),
                  _buildMenuItem('까르보나라', '16,000원'),
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
                    '월-금: 11:00 - 21:00\n토-일: 12:00 - 21:00',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildMenuItem(String name, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
