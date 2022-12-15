import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/common/utils/get_size.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/const/style.dart';
import '../../common/layout/default_layout.dart';
import '../../common/screen/loading_manager.dart';
import '../components/custom_chip.dart';
import '../provider/store_provider.dart';

class GoogleMapScreen extends ConsumerStatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends ConsumerState<GoogleMapScreen> {
  late GoogleMapController _mapController;
  late LatLng currentPosition;
  BitmapDescriptor storeIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor returnBoxIcon = BitmapDescriptor.defaultMarker;
  final Set<Marker> makers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    addCustomIcons();
    setMarkers();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      padding: 0,
      body: LoadingManager(
        isLoading: isLoading,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: makers,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              rotateGesturesEnabled: false,
              mapToolbarEnabled: false,
            ),
            Positioned(
              top: 50,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: getScreenWidth(context) - 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        DEFAULT_RADIUS,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        DEFAULT_HIGHT_PADDING + 4,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '가까운 매장을 찾아보세요',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CustomChip(),
                      SizedBox(
                        width: 10,
                      ),
                      CustomChip(),
                      SizedBox(
                        width: 10,
                      ),
                      CustomChip(),
                    ],
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.7,
              builder: (context, scrollController) {
                return Container(
                  height: getScreenHeight(context) * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        DEFAULT_RADIUS,
                      ),
                      topRight: Radius.circular(
                        DEFAULT_RADIUS,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          _updatePosition();
        },
        child: const Icon(
          Icons.location_on_outlined,
        ),
      ),
    );
  }

  //비트맵 이미지 생성
  void addCustomIcons() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/ReturnMarker.png')
        .then((icon) {
      setState(() {
        returnBoxIcon = icon;
      });
    });
  }

  Future<void> setMarkers() async {
    final data = await ref.read(storeProvider.notifier).getStore();
    final marker = data
        .map(
          (e) => Marker(
            markerId: MarkerId(e.id),
            position: LatLng(e.latitude, e.longitude),
            icon: returnBoxIcon,
            onTap: () {
              showBottomSheet(location: e.snippet, storeName: e.title);
            },
          ),
        )
        .toSet();
    setState(() {
      makers.addAll(marker);
    });
  }

  // 초기 위치
  CameraPosition _initialCameraPosition = const CameraPosition(
      target: LatLng(36.628518156306306, 127.45666120598938), zoom: 15);

  // 내 위치 업데이트
  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    currentPosition = LatLng(pos.latitude, pos.longitude);
    var cameraPosition = CameraPosition(target: currentPosition, zoom: 15);
    _mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      _initialCameraPosition = cameraPosition;
    });
  }

  // 내위치 정보 허락 받기
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      isLoading = false;
    });
  }

  void showBottomSheet({required String storeName, required String location}) =>
      showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DEFAULT_RADIUS),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 340,
            padding: const EdgeInsets.all(DEFAULT_RADIUS),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Image.asset(
                          'assets/images/bg5.jpg',
                        ),
                      ),
                      Flexible(
                        child: Image.asset(
                          'assets/images/bg5.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(storeName, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 5),
                Text(location, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: DEFAULT_HIGHT_PADDING,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 30),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "닫기",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
