//
//  TodayWeatherContainerViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import RxSwift
import Then
import SnapKit
import UIKit
import SwiftDate
final class TodayWeatherContainerViewController: BaseViewController<TodayWeatherContainerView> {
  fileprivate var containerView: TodayWeatherContainerView {
    return self.view as! TodayWeatherContainerView
  }
  
  private var summaryViewController: TodayWeatherSummaryViewController?
  private var graphViewController: TodayWeatherGraphViewController?
  private var currentSegmentIndex: Int = 0
  private let disposeBag = DisposeBag()
  private var viewModel: TodayWeatherViewModel?
  
  override func loadView() {
    self.view = TodayWeatherContainerView()
  }
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    setupChildViewController()
    
    bind()
  }
  
  convenience init(viewModel: TodayWeatherViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }
  
  override func viewWillAppear(_ animated: Bool) {
    containerView.loadingView.startAnimating()
  }
  
}
extension TodayWeatherContainerViewController {
  private func setupChildViewController() {
    guard let viewModel = self.viewModel else { return }
    summaryViewController = TodayWeatherSummaryViewController(viewModel: viewModel)
    graphViewController = TodayWeatherGraphViewController(viewModel: viewModel)
    
    add(asChildViewController: summaryViewController!)
    containerView.isSelectedSegment.onNext(0)
    
    containerView.todayWeatherSummarySegment.segmentBut.addTarget(self, action: #selector(changedSegment(_:)), for: .touchUpInside)
    containerView.todayWeatherGraphSegment.segmentBut.addTarget(self, action: #selector(changedSegment(_:)), for: .touchUpInside)
  }
  
  private func add(asChildViewController viewController: UIViewController) {
    addChild(viewController)
    
    containerView.childContainerView.addSubview(viewController.view)
    
    viewController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    viewController.didMove(toParent: self)
  }
  
  private func remove(asChildViewController viewController: UIViewController) {
    viewController.willMove(toParent: nil)
    
    viewController.view.removeFromSuperview()
    
    viewController.removeFromParent()
  }
  
  @objc private func changedSegment(_ sender: UIControl) {
    containerView.isSelectedSegment.onNext(sender.tag)
    
    guard currentSegmentIndex != sender.tag else { return }
    if sender.tag == 0 {
      remove(asChildViewController: graphViewController!)
      add(asChildViewController: summaryViewController!)
      currentSegmentIndex = 0
    } else {
      remove(asChildViewController: summaryViewController!)
      add(asChildViewController: graphViewController!)
      currentSegmentIndex = 1
    }
  }
  
  private func bind() {
    
    guard let viewModel = viewModel else { return }
    viewModel.input.didAppear()
    
    
    viewModel.weatherData.filter { !$0.weatherList.weatherList.isEmpty }
      .asDriver(onErrorJustReturn: TotalWeatherItems())
      .drive(onNext: {[weak self] _ in
        guard let self = self else { return }
        self.containerView.loadingView.stopAnimating()
      }).disposed(by: disposeBag)
    
    
    for family in UIFont.familyNames {
    iPrint("\(family)");
                
    for names in UIFont.fontNames(forFamilyName: family) {
    iPrint("== \(names)");
    }
    }
    
  }
}
