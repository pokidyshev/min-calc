//
//  CalculatorBrain.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 12.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//
//
//  Методы:
//    1) деления отрезка пополам
//    2) золотого сечения
//    3) парабол
//    4) ньютона
//

import Foundation

struct CalculatorBrain {
  @available(*, unavailable) private init() {}

  static var epsilon = 0.001

  static func Bisection(startX: Double, endX: Double, f: (Double) -> (Double)) -> Double {
    return Section(startX: startX, endX: endX, k1: 3.0/8, k2: 5.0/8, f: f)
  }

  static func GoldenSection(startX: Double, endX: Double, f: (Double) -> (Double)) -> Double {
    // коэффициенты золотого сечения
    let alpha1 = (3 - sqrt(5)) / 2
    let alpha2 = (sqrt(5) - 1) / 2

    return Section(startX: startX, endX: endX, k1: alpha1, k2: alpha2, f: f)
  }

  // Not implemented yet
  static func Parabolic(startX: Double, endX: Double, f: (Double) -> (Double)) -> Double {
    return Bisection(startX: startX, endX: endX, f: f)
  }

  static func Newton(startX: Double, endX: Double, f: (Double) -> (Double), df: (Double) -> (Double)) -> Double {
    return GoldenSection(startX: startX, endX: endX, f: f)
  }

  // MARK: Private helpers

  private static func Section(startX: Double, endX: Double, k1: Double, k2: Double, f: (Double) -> (Double)) -> Double {
    var a = startX
    var b = endX

    while (b - a) > epsilon {
      let len = b - a
      let u1 = a + k1 * len
      let u2 = a + k2 * len

      if f(u1) <= f(u2) {
        b = u2
      } else {
        a = u1
      }
    }
    
    return a // можно вернуть любую из границ
  }
}



