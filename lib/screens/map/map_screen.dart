import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/restaurant_provider.dart';
import './restaurant_bottom_sheet.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  // 지도 컨트롤러
  final MapController _mapController = MapController();

  // 기본 위치 (서울 시청)
  LatLng _currentPosition = const LatLng(37.5665, 126.9780);

  LatLng? _markerPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // 현재 위치 가져오기
  Future<void> _getCurrentLocation() async {
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        // 지도 이동
        _mapController.move(_currentPosition, 15);
      });
    } catch (e) {
      print('위치를 가져올 수 없습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 식당 목록 가져오기
    final restaurantsAsync = ref.watch(restaurantsProvider);

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition,
          initialZoom: 15.0,
        ),
        children: [
          // 기본 타일 레이어 (지도)
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),

          // 현재 위치 마커
          MarkerLayer(
            markers: [
              Marker(
                point: _currentPosition,
                width: 80,
                height: 80,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red[700],
                  size: 40,
                ),
              ),
            ],
          ),

          // 식당 마커들
          restaurantsAsync.when(
            data: (restaurants) => MarkerLayer(
              markers: restaurants.map((restaurant) {
                // 임시로 모든 식당을 서울 시청 근처에 배치
                // 실제로는 각 식당의 실제 위도/경도 정보가 필요
                final offset =
                    (restaurants.indexOf(restaurant) - restaurants.length / 2) *
                        0.001;
                return Marker(
                  point: LatLng(_currentPosition.latitude + offset,
                      _currentPosition.longitude + offset),
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => RestaurantBottomSheet(
                          restaurant: restaurant,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.blue[700],
                      size: 30,
                    ),
                  ),
                );
              }).toList(),
            ),
            loading: () => const MarkerLayer(markers: []),
            error: (error, stack) => const MarkerLayer(markers: []),
          ),
        ],
      ),
      // 현재 위치로 이동하는 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
