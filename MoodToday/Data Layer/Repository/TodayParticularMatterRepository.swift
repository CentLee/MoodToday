//
//  TodayParticularMatterRepository.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation
import Moya
import RxMoya
import RxSwift

final class TodayParticularMatterRepository: TodayParticularMatterRepositoryInterface {
  
  let provider = MoyaProvider<ParticularMatterAPI>()
  
  func fetchTodayParticularMatter(stationName: String) -> Observable<TodayParticularMatterEntity> {
    return provider.rx.request(.todayParticularMatter(stationName))
      .map { response -> TodayParticularMatterEntity in

        let decoder = JSONDecoder()
        guard !response.data.isEmpty else { return TodayParticularMatterEntity.init(pmList: []) }
        let data = try decoder.decode(ParticularMatterResponseDTO.self, from: response.data).toDomain()
        //iPrint(data)
        return data

      }.asObservable()
  }
}
