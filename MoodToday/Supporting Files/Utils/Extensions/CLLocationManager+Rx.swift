//
//  CLLocationManager+Rx.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/13.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

// 1
extension CLLocationManager: HasDelegate {
  public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
  static func registerKnownImplementations() {
    self.register { RxCLLocationManagerDelegateProxy(locationManager: $0) }
  }
  
  
  // 2
  public weak private(set) var locationManager: CLLocationManager?
  
  public init(locationManager: ParentObject) {
    self.locationManager = locationManager
    super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
  }
  
}

// 3
extension Reactive where Base: CLLocationManager {
  public var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
    return RxCLLocationManagerDelegateProxy.proxy(for: base)
  }
  
  // 4
  var didUpdateLocations: Observable<[CLLocation]> {
    return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))).map { parameters in
      return parameters[1] as! [CLLocation]
    }
  }
}

