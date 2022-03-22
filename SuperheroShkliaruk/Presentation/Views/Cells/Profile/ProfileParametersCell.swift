//
//  ProfileParametersCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import UIKit

class ProfileParametersCell: UITableViewCell {
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var bodyPartLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var valueType: UILabel!
    @IBOutlet private weak var isEnabledSwitch: UISwitch!
    @IBOutlet private weak var underlineView: UIView!
    
    static let identifier = "ProfileParametersCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        backView.backgroundColor = .clear
        
        bodyPartLabel.font = .helveticaNeueRegularWithSize18
        bodyPartLabel.textColor = .white
        
        valueTextField.font = .helveticaNeueRegularWithSize18
        valueTextField.textColor = .customGray
        
        valueType.font = .helveticaNeueMediumWithSize18
        valueType.textColor = .customGray
        
        isEnabledSwitch.onTintColor = .customYellow
        underlineView.backgroundColor = .customDarkYellow
    }
    
    public func configure(with viewModel: BodyParameterViewModel) {
        bodyPartLabel.text = viewModel.title
        valueTextField.text = "174"
        valueType.text = "cm"
        isEnabledSwitch.isOn = true
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
    }
    
}
