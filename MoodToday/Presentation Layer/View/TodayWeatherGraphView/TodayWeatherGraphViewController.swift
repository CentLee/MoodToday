//
//  TodayWeatherGraphViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import RxSwift
import RxCocoa
import Charts

final class TodayWeatherGraphViewController: BaseViewController<TodayWeatherGraphView> {
  fileprivate var graphView: TodayWeatherGraphView {
    return self.view as! TodayWeatherGraphView
  }
  
  private var viewModel: TodayWeatherViewModel?
  private let disposeBag = DisposeBag()
  private var time: [String] = []
  override func loadView() {
    self.view = TodayWeatherGraphView()
  }
  
  override func viewDidLoad() {
    bind()
    iPrint("여긴데?")
  }
  
  convenience init(viewModel: TodayWeatherViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }

  override func viewDidAppear(_ animated: Bool) {
    iPrint("dwqmodwqjpdwoq")
  }
}

extension TodayWeatherGraphViewController {
  private func bind() {
    guard let viewModel = self.viewModel else { return }
    
    Observable.of(viewModel.weatherData.value)
      .asDriver(onErrorJustReturn: TotalWeatherItems())
      .drive(onNext: {[weak self] totalWeatherItem in
        //뷰에 데이터 바인딩.
        guard let self = self else { return }

        self.bindDataWithView(data: totalWeatherItem.weatherList.weatherList)
      }).disposed(by: disposeBag)

  }
  
  private func bindDataWithView(data: [Weather]) {

    let tempList = data.filter { $0.category == "TMP" }
    
    var dataEntries: [ChartDataEntry] = []
    
    for (index, temperature) in tempList.enumerated() {
      let value = ChartDataEntry(x: Double(index), y: Double(temperature.fcstValue)!)
      dataEntries.append(value)
      iPrint(dataEntries.count)
    }
    
    let xVals = tempList.map { $0.fcstTime }
    time = xVals.map { String($0.prefix(2)) + "시" }
    iPrint(time)
    //graphView.chartView.xAxis.valueFormatter = self
    graphView.chartView.xAxis.setLabelCount(time.count, force: true)
    graphView.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: time)
    
    let lineChartSet = LineChartDataSet(entries: dataEntries, label: "온도")
    lineChartSet.colors = [.blue]
    let data = LineChartData()
    data.append(lineChartSet)
    graphView.chartView.data = data
    
    //graphView.chartView.setVisibleXRangeMaximum(24)
    graphView.chartView.fitScreen()
    //graphView.chartView.centerViewTo(xValue: graphView.chartView.chartXMax, yValue: 0, axis: YAxis.AxisDependency.right)
  }
}

