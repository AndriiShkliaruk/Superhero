//
//  HomeParametersCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 27.03.2022.
//

import UIKit

class HomeParametersCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var differenceView: UIView!
    @IBOutlet weak var differenceLabel: UILabel!
    
    static let identifier = "HomeParametersCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
        titleLabel.font = .helveticaNeueRegularWithSize16
        titleLabel.textColor = .white
        
        valueLabel.font = .helveticaNeueBoldWithSize24
        valueLabel.textColor = .customDarkYellow
        
        unitsLabel.font = .helveticaNeueRegularWithSize16
        unitsLabel.textColor = .white
        
        differenceView.layer.cornerRadius = differenceView.frame.width / 2
        differenceLabel.font = .gilroySemiboldWithSize12
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
