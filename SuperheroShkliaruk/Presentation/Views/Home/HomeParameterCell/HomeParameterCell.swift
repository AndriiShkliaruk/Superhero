//
//  HomeParameterCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 06.05.2022.
//

import UIKit

class HomeParameterCell: UITableViewCell {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var differenceView: UIView!
    @IBOutlet weak var differenceLabel: UILabel!
    
    static let identifier = "HomeParameterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        innerView.backgroundColor = .clear
        innerView.layer.cornerRadius = 10
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        
        titleLabel.font = .helveticaNeueRegularWithSize20
        titleLabel.textColor = .white
        
        valueLabel.font = .helveticaNeueBoldWithSize30
        valueLabel.textColor = .customDarkYellow
        
        unitsLabel.font = .helveticaNeueRegularWithSize20
        unitsLabel.textColor = .white
        
        differenceView.layer.cornerRadius = differenceView.frame.width / 2
        differenceLabel.font = .gilroySemiboldWithSize20
        differenceLabel.textColor = .white
    }
    
    func configure(with viewModel: ParameterViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.changedValueString
        unitsLabel.text = viewModel.units
        differenceView.backgroundColor = viewModel.differenceValueBackColor
        differenceLabel.text = viewModel.differenceValueString
    }
}