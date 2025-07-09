import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pashboi/core/constants/app_icons.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/service_centers/domain/entites/service_center_entity.dart';
import 'package:pashboi/features/public/service_centers/presentation/bloc/service_center_bloc.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ServiceCenterPage extends StatefulWidget {
  const ServiceCenterPage({super.key});

  @override
  State<ServiceCenterPage> createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  final MapController _mapController = MapController();
  LatLng _currentCenter = LatLng(23.7806, 90.4043);
  double _currentZoom = 11.0;

  LatLng parseLatLng(String lag, String lng) {
    final double? latitude = double.tryParse(lag);
    final double? longitude = double.tryParse(lng);

    if (latitude == null || longitude == null) {
      throw FormatException('Invalid coordinates: lag="$lag", lng="$lng"');
    }

    return LatLng(latitude, longitude);
  }

  void _zoomIn() {
    setState(() {
      _currentZoom++;
      _mapController.move(_currentCenter, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom--;
      _mapController.move(_currentCenter, _currentZoom);
    });
  }

  void _showDetailsDialog(BuildContext context, ServiceCenterEntity center) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(center.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (center.address.trim().isNotEmpty ?? false)
                  Text("📍 ${center.address}"),
                if (center.phone.trim().isNotEmpty ?? false)
                  Text("📞 ${center.phone}"),
                if (center.email.trim().isNotEmpty ?? false)
                  Text("✉️ ${center.email}"),
                if (center.time.trim().isNotEmpty ?? false)
                  Text("⏰ ${center.time}"),
                if (center.inChargeInfos.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'In-Charge:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (var person in center.inChargeInfos) ...[
                    if ((person.name.trim().isNotEmpty ?? false) &&
                        (person.designation.trim().isNotEmpty ?? false))
                      Text("👤 ${person.name} (${person.designation})"),
                    if (person.contactNumber.trim().isNotEmpty ?? false)
                      Text("📞 ${person.contactNumber}"),
                    if (person.email.trim().isNotEmpty ?? false)
                      Text("✉️ ${person.email}"),
                  ],
                ],
              ],
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ServiceCenterBloc>()..add(FetchServiceCenterEvent()),
      child: PageContainer(
        child: BlocBuilder<ServiceCenterBloc, ServiceCenterState>(
          builder: (context, state) {
            if (state is ServiceCenterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceCenterSuccess) {
              final serviceCenters = state.serviceCenter;

              if (serviceCenters.isEmpty) {
                return const Center(
                  child: Text("No service centers available."),
                );
              }

              return Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentCenter,
                      initialZoom: _currentZoom,
                      onPositionChanged: (position, hasGesture) {
                        setState(() {
                          _currentCenter = position.center;
                        });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.cccul',
                      ),
                      MarkerLayer(
                        markers:
                            serviceCenters.map((center) {
                              return Marker(
                                point: LatLng(
                                  double.parse(center.lat),
                                  double.parse(center.lng),
                                ),
                                width: 200,
                                height: 80,
                                child: GestureDetector(
                                  onTap:
                                      () => _showDetailsDialog(context, center),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AppIcons.pathPinIcon,
                                        width: 40,
                                        height: 40,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        center.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                            255,
                                            48,
                                            12,
                                            116,
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Column(
                      children: [
                        FloatingActionButton.small(
                          heroTag: 'zoomIn',
                          onPressed: _zoomIn,
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.small(
                          heroTag: 'zoomOut',
                          onPressed: _zoomOut,
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ServiceCenterError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const SizedBox.shrink(); // fallback
          },
        ),
      ),
    );
  }
}
