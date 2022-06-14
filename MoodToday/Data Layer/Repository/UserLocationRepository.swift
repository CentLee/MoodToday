//
//  UserLocationRepository.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import RxSwift

final class UserLocationRepository: UserLocationRepositoryInterface {
  func updateUserLocation() -> Observable<Bool> {
    LocationManager.shared.updateUserCurrentLocation()
  }
}
