//
//  ChartViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 31.03.2022.
//

import UIKit

class ChartViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var viewModel: ChartViewModel?
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        titleLabel.font = .sairaRegularWithSize24
        titleLabel.textColor = .white
        descriptionLabel.textColor = .customGray
        
        title = viewModel?.navigationBarTitle
        titleLabel.text = viewModel?.titleLabelText
        
        if let description = viewModel?.descriptionLabelText, let date = viewModel?.startDate {
            let descriptionString = NSAttributedString(string: description, attributes: [.font: UIFont.sairaMediumWithSize16])
            let dateString = NSAttributedString(string: date, attributes: [.font: UIFont.sairaMediumWithSize18])
            let unitedString = NSMutableAttributedString()
            unitedString.append(descriptionString)
            unitedString.append(dateString)
            descriptionLabel.attributedText = unitedString
        }
    }
}
