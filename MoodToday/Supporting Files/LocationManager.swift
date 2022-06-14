//
//  LocationManager.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa
import UIKit

struct Location {
  let latitude: CGFloat
  let longitude: CGFloat
  
}

final class LocationManager {
  static let shared: LocationManager = LocationManager()
  private let disposeBag = DisposeBag()
  
  var currentLocation: PublishRelay<Location> = PublishRelay<Location>()
  
  private let locationManager: CLLocationManager = CLLocationManager().then {
    $0.desiredAccuracy = kCLLocationAccuracyBest
    $0.distanceFilter = kCLDistanceFilterNone
  }
  
  private init() {
    
    locationManager.rx.didUpdateLocations
      .compactMap(\.last?.coordinate)
      .subscribe(onNext: { [weak self] location in
        guard let self = self else { return }
        self.currentLocation.accept(Location(latitude: location.latitude, longitude: location.longitude))
        print(location.latitude, location.longitude)
      }).disposed(by: disposeBag)
    
    locationManager.startUpdatingLocation()
  }
  
//  internal func updateUserCurrentLocation() {
//    requestLocation()
//
//    //locationManager.startUpdatingLocation()
//  }
  
  internal func updateUserCurrentLocation() -> Observable<Bool> {
    return Observable.create { [weak self] observer in
      guard let self = self else { return Disposables.create() }
      self.locationManager.rx.didChangeAuthorizationStatus
        .filter { $0 != .notDetermined }
        .subscribe(onNext: { [weak self] _ in
          guard let self = self else { return }
          self.locationManager.startUpdatingLocation()
          observer.onNext(true)
        })
      
      self.locationManager.requestWhenInUseAuthorization()
      
      return Disposables.create()
    }
  }
}
