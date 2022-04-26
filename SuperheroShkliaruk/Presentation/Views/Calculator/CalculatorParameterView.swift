//
//  CalculatorParameterView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 26.04.2022.
//

import UIKit

class CalculatorParameterView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var unitsLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.font = .helveticaNeueRegularWithSize18
        nameLabel.textColor = .white
        
        valueTextField.font = .helveticaNeueRegularWithSize18
        valueTextField.textColor = .customGray
        
        unitsLabel.font = .helveticaNeueMediumWithSize18
        unitsLabel.textColor = .customGray
    }
    
    func configure(name: String, units: String) {
        nameLabel.text = name
        unitsLabel.text = units
    }
}
