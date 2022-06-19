//
//  TodayParticularMatterRepositoryInterface.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation
import RxSwift

protocol TodayParticularMatterRepositoryInterface {
  func fetchTodayParticularMatter(stationName: String) -> Observable<TodayParticularMatterEntity>
}
