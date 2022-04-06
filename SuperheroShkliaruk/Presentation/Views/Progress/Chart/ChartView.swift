//
//  ChartView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 05.04.2022.
//

import UIKit

class ChartView: UIView {
    private let barWidth: CGFloat = 58
    private let sideSpace: CGFloat = 12
    
    private let textHeight: CGFloat = 25
    private let diffenceHeight: CGFloat = 25
    private let lineHeight: CGFloat = 0.5
    private let dateTopSpace: CGFloat = 4
    private let barTopSpace: CGFloat = 4
    private let valueTopSpace: CGFloat = 6
    
    private let barAnimationDuration: CFTimeInterval = 0.6
    private let textAnimationDuration: CFTimeInterval = 0.2
    private let textAnimationDelay: CFTimeInterval = 0.5
    
    private let barColor: CGColor = UIColor.customYellow.cgColor
    private let fontColor: CGColor = UIColor.white.cgColor
    private let basicFont: UIFont = .sairaRegularWithSize16
    private let differenceFont: UIFont = .gilroySemiboldWithSize14
    
    private let scrollView = UIScrollView()
    private let mainLayer = CALayer()
    
    private var maxBarHeight: CGFloat?
    private var maxBarValue: Int16?
    private var minBarValue: Int16?
    
    var dataEntries = [ChartBarViewModel]() {
        didSet {
            mainLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            
            scrollView.contentSize = CGSize(width: (barWidth + sideSpace) * CGFloat(dataEntries.count), height: frame.height)
            mainLayer.frame = CGRect(origin: .zero, size: scrollView.contentSize)
            
            maxBarHeight = mainLayer.frame.height - (textHeight * 2 + diffenceHeight + dateTopSpace + barTopSpace + valueTopSpace)
            maxBarValue = dataEntries.map { $0.value }.max()
            minBarValue = dataEntries.map { $0.value }.min()
            
            drawHorizontalLines()
            for (index, entry) in dataEntries.enumerated() {
                showEntry(index: index, entry: entry)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23 + sideSpace)
        scrollView.layer.addSublayer(mainLayer)
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func showEntry(index: Int, entry: ChartBarViewModel) {
        let x = sideSpace + ((barWidth + sideSpace) * CGFloat(index))
        
        let dateOrigin = CGPoint(x: x, y: mainLayer.frame.height - textHeight)
        drawTextLayer(text: entry.date, font: basicFont, origin: dateOrigin)
        
        var barHeight = CGFloat(entry.value)
        if let maxBarValue = maxBarValue, let maxBarHeight = maxBarHeight {
            barHeight = barHeight / CGFloat(maxBarValue) * maxBarHeight
        }
        
        let barOrigin = CGPoint(x: x, y: dateOrigin.y - (dateTopSpace + barHeight))
        drawBarLayer(origin: barOrigin, height: barHeight)
        
        let valueOrigin = CGPoint(x: x, y: barOrigin.y - (barTopSpace + textHeight))
        drawTextLayer(text: String(entry.value), font: .sairaRegularWithSize16, origin: valueOrigin)
        
        guard index != 0 else { return }
        let differenceOrigin = CGPoint(x: x, y: valueOrigin.y - (valueTopSpace + diffenceHeight))
        drawDifferenceLayer(text: entry.difference, color: entry.differenceBackColor, font: .gilroySemiboldWithSize14, origin: differenceOrigin)
    }
    
    
    //MARK: - Draw Layer Methods
    
    private func drawBarLayer(origin: CGPoint, height: CGFloat) {
        let barLayer = createBasicLayer(color: barColor, cornerRadius: 10)
        let originPoint = CGPoint(x: origin.x - barWidth / 2, y: origin.y + height / 2)
        barLayer.frame = CGRect(origin: originPoint, size: CGSize(width: barWidth, height: height))
        barLayer.anchorPoint = CGPoint(x: 0, y: 1)
        
        mainLayer.addSublayer(barLayer)
        addHeightAnimation(to: barLayer, duration: barAnimationDuration, animation: .easeOut)
    }
    
    private func drawTextLayer(text: String, font: UIFont, origin: CGPoint) {
        let textLayer = createBasicTextLayer(text: text, font: basicFont)
        textLayer.frame = CGRect(origin: origin, size: CGSize(width: barWidth, height: textHeight))
        
        mainLayer.addSublayer(textLayer)
        addOpacityAnimation(to: textLayer, duration: textAnimationDuration, delay: textAnimationDelay)
    }
    
    private func drawDifferenceLayer(text: String, color: UIColor, font: UIFont, origin: CGPoint) {
        let layer = createBasicLayer(color: color.cgColor, cornerRadius: 13)
        layer.frame = CGRect(origin: origin, size: CGSize(width: barWidth, height: diffenceHeight))
        
        let textLayer = createBasicTextLayer(text: text, font: font)
        textLayer.frame = CGRect(origin: CGPoint(x: 0, y: (diffenceHeight - font.pointSize) / 2), size: CGSize(width: barWidth, height: font.pointSize))
        
        layer.addSublayer(textLayer)
        mainLayer.addSublayer(layer)
        addOpacityAnimation(to: layer, duration: textAnimationDuration, delay: textAnimationDelay)
    }
    
    private func drawHorizontalLines() {
        guard let maxBarValue = maxBarValue,
              let maxBarHeight = maxBarHeight,
              let minBarValue = minBarValue else { return }
        
        let minBarBottomY = mainLayer.frame.height - (textHeight + dateTopSpace)
        let minBarHeight: CGFloat = maxBarHeight / CGFloat(maxBarValue) * CGFloat(minBarValue)
        
        let topLineY = minBarBottomY - minBarHeight - lineHeight
        let topLine = createBasicHorizontalLine(positionY: topLineY, dashPattern: [3, 3])
        
        let bottomLineY = minBarBottomY + lineHeight
        let bottomLine = createBasicHorizontalLine(positionY: bottomLineY, dashPattern: nil)
        
        layer.insertSublayer(topLine, at: 0)
        layer.addSublayer(bottomLine)
        addOpacityAnimation(to: topLine, duration: textAnimationDuration, delay: textAnimationDelay)
    }
    
    
    //MARK: - Basic Layer Methods
    
    private func createBasicLayer(color: CGColor, cornerRadius: CGFloat) -> CALayer {
        let layer = CALayer()
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = color
        return layer
    }
    
    private func createBasicTextLayer(text: String, font: UIFont) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.foregroundColor = fontColor
        textLayer.alignmentMode = .center
        return textLayer
    }
    
    private func createBasicHorizontalLine(positionY: CGFloat, dashPattern: [NSNumber]?) -> CAShapeLayer {
        let line = CAShapeLayer()
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = lineHeight
        if let lineDashPattern = dashPattern {
            line.lineDashPattern = lineDashPattern
        }
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: positionY))
        linePath.addLine(to: CGPoint(x: frame.width, y: positionY))
        line.path = linePath.cgPath
        return line
    }
    
    
    //MARK: - Animation Methods
    
    private func addHeightAnimation(to layer: CALayer, duration: CFTimeInterval, animation: CAMediaTimingFunctionName) {
        let heightAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        heightAnimation.fromValue = 0
        heightAnimation.toValue = layer.bounds.size.height
        heightAnimation.duration = duration
        heightAnimation.timingFunction = CAMediaTimingFunction(name: animation)
        layer.add(heightAnimation, forKey: nil)
    }
    
    private func addOpacityAnimation(to layer: CALayer, duration: CFTimeInterval, delay: CFTimeInterval) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        opacityAnimation.duration = duration
        opacityAnimation.beginTime = CACurrentMediaTime() + delay
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = .forwards
        layer.opacity = 0
        layer.add(opacityAnimation, forKey: nil)
    }
}
