//
//  MapViewModel.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 07/09/2023.
//

import MapKit


enum MapDetails{
    static let startingLocation = CLLocationCoordinate2D(latitude: 5.616994429586594, longitude: -0.1915960195426733)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
//LOCATION MANAGER
//CHECK IF LOCATION SERVICES ARE ENABLED

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager : CLLocationManager?
    
    func checkIfLlocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
 
        }else{
            print("Alert that loaction is off and to go turn it on")
        }
    }
    
    //CHECK IF YOUR APP HAS PERMISSION TO USE LOCATION SERVICES
    private func checkLoactionAuthorization(){
        guard let locationManager = locationManager else {
            return
        }
        //CHECK ALL CASES(STATUS) ON LOCATION AUTHORIZATION
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location has been restricted likely due to parental control")
        case .denied:
            print("You have denied this app location services. Go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate ,
                                        span: MapDetails.defaultSpan)
            
        @unknown default:
            break
        }

    }
    
    //FUNCTION TO LISTEN FOR CHANGE IN LOCATION SERVICES AUTHORIZATION
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLoactionAuthorization()
    }
}


