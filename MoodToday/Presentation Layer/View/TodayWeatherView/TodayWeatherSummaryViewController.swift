//
//  TodayWeatherSummaryViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation
import RxSwift
import UIKit

final class TodayWeatherSummaryViewController: BaseViewController<TodayWeatherSummaryView> {
  
  fileprivate var todayWeatherView: TodayWeatherSummaryView {
    return self.view as! TodayWeatherSummaryView
  }
  
  private var viewModel: TodayWeatherViewModel?
  private let disposeBag = DisposeBag()
  override func loadView() {
    self.view = TodayWeatherSummaryView()
  }

  convenience init(viewModel: TodayWeatherViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    print("dqw")
    
    todayWeatherView.particulateMatterView.circleView.ringColor = .gray
    bind()
  }
  
  
}

extension TodayWeatherSummaryViewController {
  private func bind() {
    guard let viewModel = self.viewModel else { return }
    viewModel.weatherData.filter { !$0.weatherList.weatherList.isEmpty }
      .asDriver(onErrorJustReturn: TotalWeatherItems())
      .drive(onNext: {[weak self] totalWeatherItem in
        //뷰에 데이터 바인딩.
        guard let self = self else { return }
        self.bindDataWithView(data: totalWeatherItem)
      }).disposed(by: disposeBag)
  }
  
  private func bindDataWithView(data: TotalWeatherItems) {
    let weather = data.weatherList.weatherList[0..<12]
    let pm = data.particularMatterList.pmList
    
    todayWeatherView.locationTitle.text = "현재 위치는 \(data.currentLocation)입니다."
    todayWeatherView.temperatureTitle.text = "현재 기온: \(weather.filter{$0.category == "TMP"}.first!.fcstValue)℃"
    todayWeatherView.humidityStackView.stackItemSubTitle.text = "\(weather.filter{$0.category == "REH"}.first!.fcstValue)%"
    todayWeatherView.windyStackView.stackItemSubTitle.text = "\(weather.filter{$0.category == "VEC"}.first!.totalWindDirection()) \(weather.filter { $0.category == "WSD" }.first!.fcstValue) m/s"
    todayWeatherView.rainStackView.stackItemSubTitle.text = "\(weather.filter { $0.category == "PCP" }.first!.fcstValue == "강수없음" ? "-" : weather.filter { $0.category == "PCP" }.first!.fcstValue) mm"
    todayWeatherView.fetchTimeTitle.text = data.currentTime
    
    let pmData = pm.first!.toPmData()
    let upmData = pm.first!.toUpmData()

    todayWeatherView.ultraParticulateMatterView.mainTitle.text = "\(pm.first!.ultraPmValue)\n㎍/m³"
    todayWeatherView.ultraParticulateMatterView.circleView.mainColor = upmData.0.withAlphaComponent(0.1)
    todayWeatherView.ultraParticulateMatterView.circleView.ringColor = upmData.0.withAlphaComponent(0.7)
    todayWeatherView.ultraParticulateMatterView.circleView.progressColor = upmData.0
    todayWeatherView.ultraParticulateMatterView.circleView.progressValue = Double(pm.first!.ultraPmValue)
    todayWeatherView.ultraParticulateMatterView.particulateMatterConcentrationStateView.text = "\(upmData.1)"
    todayWeatherView.ultraParticulateMatterView.circleView.setNeedsDisplay()
    
    todayWeatherView.particulateMatterView.mainTitle.text = "\(pm.first!.pmValue)\n㎍/m³"
    todayWeatherView.particulateMatterView.circleView.mainColor = pmData.0.withAlphaComponent(0.2)
    todayWeatherView.particulateMatterView.circleView.ringColor = pmData.0.withAlphaComponent(0.7)
    todayWeatherView.particulateMatterView.circleView.progressColor = pmData.0
    todayWeatherView.particulateMatterView.circleView.progressValue = Double(pm.first!.pmValue)
    todayWeatherView.particulateMatterView.particulateMatterConcentrationStateView.text = "\(pmData.1)"
    todayWeatherView.particulateMatterView.circleView.setNeedsDisplay()
    
    iPrint(data.currentTime)
  }
}
