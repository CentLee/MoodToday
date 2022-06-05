//
//  UIPreView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
  let view: View

  init(_ builder: @escaping () -> View) {
    self.view = builder()
  }

  func makeUIView(context: Context) -> UIView {
    return self.view
  }

  func updateUIView(_ view: UIView, context: Context) {

  }
}
#endif
