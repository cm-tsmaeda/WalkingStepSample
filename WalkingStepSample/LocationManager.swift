//
//  LocationManager.swift
//  WalkingStepSample
//
//  Created by Tasuku Maeda on 2025/08/31.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManger = CLLocationManager()
    
    static var shared = LocationManager()
    private override init() {
        
    }
    
    func setup() {
        locationManger.delegate = self
        
        let status = locationManger.authorizationStatus
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        case .notDetermined:
            requestAuthorize()
        default:
            break
        }
    }
    
    func requestAuthorize() {
        locationManger.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization status=\(status)")
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManger.requestAlwaysAuthorization()
        case .denied,
             .restricted,
             .notDetermined:
            break
        default:
            break
        }
    }
    
    func startUpdateLocation() {
        locationManger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations locations=\(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError error=\(error.localizedDescription)")
    }
}
