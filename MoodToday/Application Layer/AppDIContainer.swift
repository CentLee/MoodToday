//
//  AppDIContainer.swift
//  MoodToday
//
//  Created by 이창화 on 2022/05/28.
//

import Foundation

final class AppDIContainer {
  static let shared: AppDIContainer = AppDIContainer()
  
  public func todayWeatherDependencies() -> TodayWeatherViewModel {
    let weatherUseCase = FetchTodayWeatherUseCase(repository: TodayWeatherRepository())
    let particularMatterUseCase = FetchTodayPMUseCase(repository: TodayParticularMatterRepository())
    let viewModel = TodayWeatherViewModel(weatherUseCase: weatherUseCase, particularMatterUseCase: particularMatterUseCase)
    
    return viewModel
  }
  
  public func userLocationDependencies() -> AgreementViewModel {
    let useCase = UpdateUserLocationUseCase(repository: UserLocationRepository())
    
    let viewModel = AgreementViewModel(useCase: useCase)
    
    return viewModel
  }
}
