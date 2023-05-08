import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class PetaProvider with ChangeNotifier{
  LocationAccuracy _accuracy = LocationAccuracy.low;
  LatLng latLng = LatLng(0, 0);
  LatLng latLng_lama = LatLng(0, 0);
  double radius = 20;
  // LatLng titiktengah =  LatLng(-0.058691324891420024, 109.35592918837658);
  LatLng titiktengah =  LatLng(-0.061864789802221584, 109.35464312555375);

  MapController mapController = MapController();
  bool mapReady = false;
  bool mulaibaca = false;

  void hitungulang(){
    final zoom = mapController.zoom;
    radius = zoom > 13 ? (zoom - 13) * 7.5 : 0;
    // 13	14	15	16	17
    // 0	7.5	15	22.5	30

    print('radius $radius');
  //  radius = 30 * zoom / 17;
    notifyListeners();
  }

  double hitungjarak(){
    final startLatitude = titiktengah.latitude;
    final startLongitude = titiktengah.longitude;
    final endLatitude = latLng.latitude;
    final endLongitude = latLng.longitude;

    final r = Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    return r;
  }

  void mulai_bacalokasi(){
    if(mulaibaca == false){
      mulaibaca = true;
      _bacalokasi();
    }
  }
  
  void stop_bacalokasi(){
    mulaibaca = false;
  }

  Future<bool> cekIzin() async{
    var izin = await Geolocator.checkPermission();
    if(izin != LocationPermission.always &&
        izin != LocationPermission.whileInUse){
          izin = await Geolocator.requestPermission();
        }
    if(izin != LocationPermission.always &&
        izin != LocationPermission.whileInUse){
          return false;
        }
    return true;
  }

  Future _bacalokasi()async{
    final izin = await cekIzin();
    if(izin == false)return;

    try {
      // Baca lokasi sesuai akurasi yang ditentukan
      final lokasi = await Geolocator.getCurrentPosition( desiredAccuracy: _accuracy );

      // Simpan koordinat dari lokasi latitude dan longtitude ke property latlng
      latLng = LatLng(lokasi.latitude, lokasi.longitude);
      naikkan_akurasi(); // <-- naikkan lokasi karena tidak error

      if( mapReady == true ){ // Jika mapReady (sudah siap)
      //baca jarak antara posisi baru dengan posisi sebelumnya
        final jarak = Geolocator.distanceBetween(
                latLng.latitude,
                latLng.longitude,
                latLng_lama.latitude,
                latLng_lama.longitude
        // Jika jarak perbedaan lebih dari 100m
        );
        if( jarak > 100 ){
          latLng_lama = latLng; // <-- Simpan posisi baru ke posisi lama
          // Pindahkan kamera tampilan map ke posisi baru
          mapController.move(latLng, mapController.zoom);
        }
      }

      print('dapat lokasi $lokasi');
    } catch (e) {
      print('error lokasi $e');
      turunkan_akurasi();
    }

    if(mulaibaca == true){
      //Tunggu 1 detik agar aplikasi tidak lag
      await Future.delayed( Duration(seconds: 1));
      _bacalokasi(); // Panggil kembali _baca lokasi
    }
  }

  void turunkan_akurasi(){
    if( _accuracy == LocationAccuracy.bestForNavigation ){
        _accuracy = LocationAccuracy.best;
    }else if(_accuracy == LocationAccuracy.best){
        _accuracy = LocationAccuracy.medium;
    }else if(_accuracy == LocationAccuracy.medium){
        _accuracy = LocationAccuracy.low;
    }
  }

  void naikkan_akurasi(){
    if( _accuracy == LocationAccuracy.low){
        _accuracy = LocationAccuracy.medium;
    }else if( _accuracy == LocationAccuracy.medium){
        _accuracy = LocationAccuracy.best;
    }else if( _accuracy == LocationAccuracy.best){
        _accuracy = LocationAccuracy.bestForNavigation;
    }
  }
}