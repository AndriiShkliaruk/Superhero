//
//  CustomSegmentedControl.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 01.05.2022.
//

import UIKit

class CustomSegmentedControl: UIControl {
    private var buttons = [UIButton]()
    private var selector: UIView!
    var selectedSegmentIndex = 0
    
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var textColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    var selectorColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    var selectorTextColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 16) {
        didSet {
            updateView()
        }
    }
    
    var segmentedTitles: [String] = [] {
        didSet {
            updateView()
        }
    }
    
    override func draw(_ rect: CGRect) {
        updateView()
    }
    
    private func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        buttons = segmentedTitles.map { title in
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = font
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            return button
        }
        
        if let firstButton = buttons.first {
            firstButton.setTitleColor(selectorTextColor, for: .normal)
        }
        
        let selectorWidth = frame.width / CGFloat(segmentedTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.layer.borderColor = UIColor.red.cgColor
        stackView.frame = bounds
        addSubview(stackView)
        clipsToBounds = true
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        buttons.enumerated().forEach { index, button in
            if button == sender {
                selectedSegmentIndex = index
                
                let startPositionX = frame.width / CGFloat(buttons.count) * CGFloat(index)
                UIView.animate(withDuration: 0.1) {
                    self.selector.frame.origin.x = startPositionX
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            } else {
                button.setTitleColor(textColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
}
