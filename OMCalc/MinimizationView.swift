//
//  MinimizationView.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 24.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

@IBDesignable
class MinimizationView: GraphView {

  @IBInspectable var pointsColor: UIColor = UIColor.red { didSet { setNeedsDisplay() } }
  @IBInspectable var minColor: UIColor = UIColor.green { didSet { setNeedsDisplay() } }

  var points = [CGFloat]() { didSet { setNeedsDisplay() } }
  var minX: CGFloat? { didSet { setNeedsDisplay() } }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawPoints()
  }

  private func drawPoints() {
    if let f = function {
      pointsColor.set()
      for x in points {
        draw(point: scaleAndShift(x: x, y: f(x)))
      }
      if let minX = minX {
        let point = scaleAndShift(x: minX, y: f(minX))
        let line = UIBezierPath()
        minColor.set()
        draw(point: point)
        // add horizontal line
        line.move(to: point)
        line.addLine(to: CGPoint(x: origin.x, y: point.y))
        line.lineWidth = 0.6
        line.stroke()
      }
    }
  }

  private func draw(point: CGPoint) {
    let circle = UIBezierPath()
    circle.addArc(withCenter: point, radius: 4.0, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: true)

    let line = UIBezierPath()
    line.move(to: point)
    line.addLine(to: CGPoint(x: point.x, y: origin.y))

    line.lineWidth = 0.6
    circle.fill()
    line.stroke()
  }
}
