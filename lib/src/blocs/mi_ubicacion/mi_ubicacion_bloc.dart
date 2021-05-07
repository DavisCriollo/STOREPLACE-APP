import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

// Cancelo el Stream de seguimiento
  StreamSubscription<Position> _cancelarSeguimiento;

void iniciarSegimiento() {
    Geolocator.GeolocatorPlatform.instance
        .getPositionStream(
            desiredAccuracy: Geolocator.LocationAccuracy.high,
            distanceFilter: 5)
        .listen((Geolocator.Position position) {
      print('Lat=> $position');
      // final nuevaUbicacion = new LatLng(
      //   position.latitude,
      //   position.longitude,
      // );
      // add(OnbicacionCambio(nuevaUbicacion));
    });
  }
   void cancelarSeguimiento() {
    _cancelarSeguimiento?.cancel();
  }





  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {}
}
