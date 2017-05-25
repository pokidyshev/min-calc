//
//  CalculatorVC.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 12.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
  @IBOutlet weak var methodTextBox: UITextField!
  @IBOutlet weak var methodDropDown: UIPickerView!

  @IBOutlet weak var startTextField: UITextField!
  @IBOutlet weak var endTextField: UITextField!

  var currentMethod: String {
    return methodTextBox.text ?? ""
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    splitViewController?.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    methodTextBox.text = methodsPickerData[0]
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let graphVC = segue.destination.contents as? GraphVC else {
      return
    }

    let f: (Double) -> Double = { sin($0) }
    let df: (Double) -> Double = { cos($0) }

    let start = Double(startTextField.text ?? "")!
    let end = Double(endTextField.text ?? "")!

    var minX: Double
    switch currentMethod {
    case "Бисекция":
      minX = CalculatorBrain.Bisection(startX: start, endX: end, f: f)
    case "Золотое сечение":
      minX = CalculatorBrain.GoldenSection(startX: start, endX: end, f: f)
    case "Парабол":
      minX = CalculatorBrain.Parabolic(startX: start, endX: end, f: f)
    case "Ньютона":
      minX = CalculatorBrain.Newton(startX: start, endX: end, f: f, df: df)
    default:
      return
    }

    graphVC.function = f
    graphVC.points = [ start, end ]
    graphVC.minX = minX
    graphVC.title = "(\(minX.rounded(places: 2)), \(f(minX).rounded(places: 2)))"
  }

  fileprivate let methodsPickerData = [ "Бисекция", "Золотое сечение", "Парабол", "Ньютона" ]
}


extension CalculatorVC: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    view.endEditing(true)
    return methodsPickerData[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    methodTextBox.text = methodsPickerData[row]
  }
}


extension CalculatorVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return methodsPickerData.count
  }
}


extension CalculatorVC: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    let dropDownIsHidden = self.methodDropDown.isHidden
    let alphaDuration = dropDownIsHidden ? 0.0 : 0.2

    UIView.animate(withDuration: alphaDuration, delay: 0, options: [], animations: {
      self.methodDropDown.alpha = 1 - self.methodDropDown.alpha
    }) { finished in
      UIView.animate(withDuration: 0.4, animations: {
        self.methodDropDown.isHidden = !self.methodDropDown.isHidden
      })
    }

    return false
  }
}

extension UIViewController {
  var contents: UIViewController {
    if let navcon = self as? UINavigationController {
      return navcon.visibleViewController ?? self
    }
    return self
  }
}

extension CalculatorVC: UISplitViewControllerDelegate {
  func splitViewController(
    _ splitViewController: UISplitViewController,
    collapseSecondary secondaryViewController: UIViewController,
    onto primaryViewController: UIViewController
  ) -> Bool {
    if primaryViewController.contents == self {
      if let gvc = secondaryViewController.contents as? GraphVC,
        gvc.function == nil
      {
        return true
      }
    }
    return false
  }
}

extension Double {
  /// Rounds the double to decimal places value
  func rounded(places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}


