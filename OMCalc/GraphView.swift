//
//  GraphView.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 17.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

  @IBInspectable var pointsPerUnit: CGFloat = 40.0 { didSet { setNeedsDisplay() } }
  @IBInspectable var graphColor: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
  @IBInspectable var origin: CGPoint = CGPoint(x: 250.0, y: 350.0) { didSet { setNeedsDisplay() } }

  var function: ((CGFloat) -> CGFloat)? { didSet { setNeedsDisplay() } }

  private var axesDrawer = AxesDrawer(color: UIColor.black)

  func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer) {
    switch pinchRecognizer.state {
    case .changed, .ended:
      pointsPerUnit *= pinchRecognizer.scale
      pinchRecognizer.scale = 1
    default:
      break
    }
  }

  override func draw(_ rect: CGRect) {
    axesDrawer.drawAxes(in: rect, origin: origin, pointsPerUnit: pointsPerUnit)
    graphColor.setStroke()
    pathForFunction().stroke()
  }

  func shift(p: CGPoint) -> CGPoint {
    return CGPoint(x: p.x + origin.x, y: origin.y - p.y)
  }
  func scale(x: CGFloat, y: CGFloat) -> CGPoint {
    return CGPoint(x: x * pointsPerUnit, y: y * pointsPerUnit)
  }
  func scaleAndShift(x: CGFloat, y: CGFloat) -> CGPoint {
    return shift(p: scale(x: x, y: y))
  }

  private func pathForFunction() -> UIBezierPath {
    let path = UIBezierPath()

    if let f = function {
      let step: CGFloat = 0.1
      let endX = max(bounds.maxX - origin.x, bounds.maxX)
      var x = min(-origin.x, bounds.minX)

      path.lineWidth = 2.0
      path.move(to: scaleAndShift(x: x, y: f(x)))

      while x < endX {
        x += step
        path.addLine(to: scaleAndShift(x: x, y: f(x)))
      }
    }

    return path
  }
}


