//
//  GraphVC.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 17.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

class GraphVC: UIViewController {
  @IBOutlet weak var graphView: MinimizationView! {
    didSet {
      graphView.origin = graphView.center
      graphView.addGestureRecognizer(UIPinchGestureRecognizer(
        target: graphView,
        action: #selector(GraphView.changeScale(byReactingTo:))
      ))

      UpdateUI()
    }
  }

  var function: ((Double) -> Double)?
  var points = [Double]()
  var minX: Double?

  @IBAction func handlePan(byReactinTo panRecognizer: UIPanGestureRecognizer) {
    let translation = panRecognizer.translation(in: graphView)
    if let view = panRecognizer.view as? GraphView {
      view.origin = CGPoint(x: view.origin.x + translation.x,
                            y: view.origin.y + translation.y)
    }
    panRecognizer.setTranslation(CGPoint.zero, in: graphView)
  }

  private func UpdateUI() {
    if function != nil {
      graphView.function = { [unowned self] in CGFloat((self.function!(Double($0)))) }
    }
    graphView.points = points.map { CGFloat($0) }
    if minX != nil {
      graphView.minX = CGFloat(minX!)
    }
  }
}
