//
//  CalculatorVC.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 12.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
  @IBOutlet weak var methodPicker: UIPickerView!

  override func viewDidLoad() {
    super.viewDidLoad()

    methodPicker.dataSource = self
    methodPicker.delegate = self
  }

  fileprivate let methodsPickerData = [ "Бисекция", "Золотое сечение", "Парабол", "Ньютона" ]
}

extension CalculatorVC: UIPickerViewDelegate, UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return methodsPickerData.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return methodsPickerData[row]
  }
}
