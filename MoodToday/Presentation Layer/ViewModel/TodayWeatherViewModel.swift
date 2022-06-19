//
//  TodayWeatherViewModel.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation
import RxSwift
import RxRelay

struct TotalWeatherItems {
  let currentLocation: String
  let currentTime: String
  let weatherList: TodayWeatherEntity
  let particularMatterList: TodayParticularMatterEntity
  
  init(currentLocation: String = "",
       currentTime: String = "",
       weatherList: TodayWeatherEntity = TodayWeatherEntity(),
       particularMatterList: TodayParticularMatterEntity = TodayParticularMatterEntity()) {
    self.currentTime = currentTime
    self.currentLocation = currentLocation
    self.weatherList = weatherList
    self.particularMatterList = particularMatterList
  }
}

protocol TodayWeatherViewModelInput {
  func didAppear()
}

protocol TodayWeatherViewModelOutput {
  var weatherData: BehaviorRelay<TotalWeatherItems> { get set }
}

protocol TodayWeatherViewModelType: TodayWeatherViewModelInput, TodayWeatherViewModelOutput {
  var input: TodayWeatherViewModelInput { get }
  var output: TodayWeatherViewModelOutput { get }
}


final class TodayWeatherViewModel: TodayWeatherViewModelType {
  var input: TodayWeatherViewModelInput { return self }
  var output: TodayWeatherViewModelOutput { return self }
  
  private let baseTimeArray: [String] = ["0200", "0500", "0800", "1100", "1400", "1700", "2000", "2300"]
  
  private let weatherUseCase: FetchTodayWeatherUseCaseInterface
  private let particularMatterUseCase: FetchTodayPMUseCaseInterface
  var weatherData: BehaviorRelay<TotalWeatherItems> = BehaviorRelay<TotalWeatherItems>(value: TotalWeatherItems())
  //var (si, gu) = ("","")
  private let disposeBag: DisposeBag = DisposeBag()
  
  public init(weatherUseCase: FetchTodayWeatherUseCaseInterface,
              particularMatterUseCase: FetchTodayPMUseCaseInterface) {
    self.weatherUseCase = weatherUseCase
    self.particularMatterUseCase = particularMatterUseCase
  }
  
}

extension TodayWeatherViewModel {
  
  func didAppear() {
    let currentLocation = LocationManager.shared.currentLocation
    
    currentLocation.take(1)
      .concatMap { location -> Observable<(String, String, Location)> in
        let converter = LocationConverter()
        return Observable.create { observer in
          Task {
            do {
              for try await value in converter.convertAddress(lon: location.longitude, lat: location.latitude).values {
                observer.onNext((value.0, value.1, location))
                observer.onCompleted()
              }
            }
          }
          return Disposables.create()
        }
      }
      .concatMap { (si, gu, location) -> Observable<TotalWeatherItems> in
        let converter = LocationConverter()
        let (nx, ny) = converter.convertGrid(lon: location.longitude, lat: location.latitude)
        let (date, time) = self.currentDate()

        return Observable.zip(self.weatherUseCase.execute(requestValue:
                                                            FetchTodayWeatherRequestValue(currentTime: time, currentDate: date,
                                                                                          gridX: String(nx), girdY: String(ny))),
                              self.particularMatterUseCase.execute(stationName: gu))
        .map {(weather, particularMatter) -> TotalWeatherItems in
          let realTime = self.currentDate(baseFlag: false).1
          var weatherData = weather
          weatherData.weatherList = weather.weatherList.filter { $0.fcstDate > date || $0.fcstTime.prefix(2) >= realTime.prefix(2) }
          
          let totalData = TotalWeatherItems(currentLocation: "\(si) \(gu)",
                                            currentTime: "\(date) \(realTime.prefix(2))시 갱신",
                                            weatherList: weatherData,
                                            particularMatterList: particularMatter)
          return totalData
        }
      }
      .subscribe { items in
        self.weatherData.accept(items)
      }.disposed(by: disposeBag)
  }
  
  func currentDate(baseFlag: Bool = true) -> (String, String) {
    let formatter: DateFormatter = DateFormatter().then {
      $0.dateFormat = "yyyyMMdd HHmm"
    }
    
    let currentDate = Date()
    let component = formatter.string(from: currentDate).split(separator: " ")
    let date = String(component[0])
    
    let time = baseTimeArray.filter { $0 < String(component[1]) }.last ?? baseTimeArray.first!
    
    return (date, baseFlag ? time : String(component[1]))
  }
}
