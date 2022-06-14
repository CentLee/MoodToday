//
//  UserLocationRepositoryInterface.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import RxSwift

protocol UserLocationRepositoryInterface {
  func updateUserLocation() -> Observable<Bool>
}
