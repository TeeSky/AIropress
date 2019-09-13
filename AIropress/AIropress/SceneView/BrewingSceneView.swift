//
//  BrewingSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class BrewingSceneView: BaseSceneView {

    lazy var safeAreaContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var mainTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var phaseLabelsContainer: UIView = {
        return UIView()
    }()
    
    lazy var currentPhaseTimerLabel: PhaseLabelView = {
        let phaseLabel = PhaseLabelView()
        phaseLabel.setScale(scale: .normal)
        return phaseLabel
    }()
    
    lazy var next1TimerLabel: PhaseLabelView = {
        let phaseLabel = PhaseLabelView()
        phaseLabel.setScale(scale: .small)
        return phaseLabel
    }()
    
    lazy var next2TimerLabel: PhaseLabelView = {
        let phaseLabel = PhaseLabelView()
        phaseLabel.setScale(scale: .smallest)
        return phaseLabel
    }()

    
    override func addViews() {
        addSubview(safeAreaContainer)
        addSubview(mainTimerLabel)
        addSubview(phaseLabelsContainer)
        
        phaseLabelsContainer.addSubview(currentPhaseTimerLabel)
        phaseLabelsContainer.addSubview(next1TimerLabel)
        phaseLabelsContainer.addSubview(next2TimerLabel)
    }
    
    override func setContraints() {
        safeAreaContainer.edgesToSuperview(insets: TinyEdgeInsets(horizontal: 5), usingSafeArea: true)
        
        mainTimerLabel.height(200)
        mainTimerLabel.edges(to: safeAreaContainer, excluding: .bottom)
        
        phaseLabelsContainer.stack([currentPhaseTimerLabel, next1TimerLabel, next2TimerLabel], axis: .vertical, spacing: 5)
        phaseLabelsContainer.edges(to: safeAreaContainer, excluding: .init(arrayLiteral: [.top, .bottom]), insets: .init(horizontal: 15))
        phaseLabelsContainer.centerYToSuperview()
    }
    
}

class PhaseLabelView: UIView {
    
    var textLabel: UILabel!
    var timerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViews()
        setConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func addViews() {
        textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.textColor = .black
        textLabel.lineBreakMode = .byTruncatingTail
        
        timerLabel = UILabel()
        timerLabel.alpha = 0.6
        timerLabel.textAlignment = .right
        timerLabel.textColor = .black
        
        self.addSubview(textLabel)
        self.addSubview(timerLabel)
    }
    
    private func setConstraints() {
        timerLabel.width(75)
        
        textLabel.leftToSuperview()
        textLabel.rightToSuperview()
        
        timerLabel.bottomToSuperview()
        timerLabel.rightToSuperview()
        
//        textLabel.rightToLeft(of: timerLabel, offset: -15, relation: .equalOrLess, priority: .required)
    }
    
    func setScale(scale: Scale) {
        textLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().text)
        timerLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().timer)
        
        self.alpha = scale.alpha()
        self.height(scale.height())
        textLabel.bottomToSuperview(offset: -scale.fontSizes().timer)
    }
    
    func configure(with textSet: PhaseTextSet?) {
        if let textSet = textSet {
            textLabel.text = textSet.labelText
            timerLabel.text = textSet.timerText
        } else {
            textLabel.text = ""
            timerLabel.text = ""
        }
    }
    
    enum Scale {
        case normal
        case small
        case smallest
        
        func height() -> CGFloat {
            switch self {
            case .normal:
                return 200
            case .small:
                return 50
            case .smallest:
                return 40
            }
        }
        
        func fontSizes() -> (text: CGFloat, timer: CGFloat) {
            switch self {
            case .normal:
                return (27, 20)
            case .small:
                return (20, 15)
            case .smallest:
                return (16, 12)
            }
        }
        
        func alpha() -> CGFloat {
            switch self {
            case .normal:
                return 1
            case .small:
                return 0.7
            case .smallest:
                return 0.4
            }
        }
    }
}
