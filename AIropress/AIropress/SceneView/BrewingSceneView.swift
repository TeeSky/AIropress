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
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        return label
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
        addSubview(currentPhaseTimerLabel)
        addSubview(next1TimerLabel)
        addSubview(next2TimerLabel)
    }
    
    override func setContraints() {
        safeAreaContainer.edgesToSuperview(usingSafeArea: true)
        
        mainTimerLabel.height(150)
        
        safeAreaContainer.stack([mainTimerLabel, currentPhaseTimerLabel, next1TimerLabel, next2TimerLabel], axis: .vertical, spacing: 5)
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
        textLabel.textAlignment = .left
        textLabel.textColor = .black
        
        timerLabel = UILabel()
        timerLabel.width(50)
        timerLabel.textAlignment = .right
        timerLabel.textColor = .black
        
        self.addSubview(textLabel)
        self.addSubview(timerLabel)
    }
    
    private func setConstraints() {
        textLabel.bottomToSuperview()
        textLabel.leftToSuperview()
        
        timerLabel.bottomToSuperview()
        timerLabel.rightToSuperview()
        
        textLabel.rightToLeft(of: timerLabel, offset: 15, relation: .equalOrGreater)
    }
    
    func setScale(scale: Scale) {
        textLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().text)
        timerLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().timer)
        
        self.alpha = scale.alpha()
    }
    
    func configure(with textSet: PhaseTextSet) {
        textLabel.text = textSet.labelText
        timerLabel.text = textSet.timerText
    }
    
    enum Scale {
        case normal
        case small
        case smallest
        
        func fontSizes() -> (text: CGFloat, timer: CGFloat) {
            switch self {
            case .normal:
                return (25, 22)
            case .small:
                return (20, 17)
            case .smallest:
                return (18, 15)
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
