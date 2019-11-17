//
//  BrewingSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 13/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class BrewingSceneView: BaseSceneView {

    lazy var safeAreaContainer: UIView = {
        let container = UIView()
        return container
    }()

    lazy var mainTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 47, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var phaseLabelsContainer: UIView = {
        UIView()
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

    lazy var stopButton: UIButton = {
        BaseSceneView.createNegativeButton(title: "Stop")
    }()

    override func addViews() {
        super.addViews()

        addSubview(safeAreaContainer)
        addSubview(mainTimerLabel)
        addSubview(phaseLabelsContainer)
        addSubview(stopButton)

        phaseLabelsContainer.addSubview(currentPhaseTimerLabel)
        phaseLabelsContainer.addSubview(next1TimerLabel)
        phaseLabelsContainer.addSubview(next2TimerLabel)
    }

    override func setColors() {
        super.setColors()

        mainTimerLabel.textColor = Style.Color.text
        BaseSceneView.colorizeButton(stopButton, backgroundColor: Style.Color.buttonNegative)
    }

    override func setConstraints() {
        super.setConstraints()

        safeAreaContainer.edgesToSuperview(insets: TinyEdgeInsets(size: 15), usingSafeArea: true)

        mainTimerLabel.height(180)
        mainTimerLabel.edges(to: safeAreaContainer, excluding: .bottom)

        phaseLabelsContainer.stack(
            [currentPhaseTimerLabel, next1TimerLabel, next2TimerLabel],
            axis: .vertical, spacing: 10
        )
        phaseLabelsContainer.edges(
            to: safeAreaContainer, excluding: .init(arrayLiteral: [.top, .bottom]),
            insets: .init(horizontal: 5)
        )
        phaseLabelsContainer.centerYToSuperview()

        stopButton.edges(to: safeAreaContainer, excluding: .init(arrayLiteral: [.top, .right]))
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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        textLabel.textColor = Style.Color.text
        timerLabel.textColor = Style.Color.text
    }

    private func addViews() {
        textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.lineBreakMode = .byTruncatingTail

        timerLabel = UILabel()
        timerLabel.alpha = 0.6
        timerLabel.textAlignment = .right

        addSubview(textLabel)
        addSubview(timerLabel)
    }

    private func setConstraints() {
        timerLabel.width(75)

        textLabel.edgesToSuperview(excluding: .bottom)

        timerLabel.bottomToSuperview()
        timerLabel.rightToSuperview()

//        textLabel.rightToLeft(of: timerLabel, offset: -15, relation: .equalOrLess, priority: .required)
    }

    func setScale(scale: Scale) {
        textLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().text)
        timerLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().timer)

        alpha = scale.alpha()
        height(scale.height())
        textLabel.bottomToSuperview(offset: -scale.fontSizes().timer)
    }

    func configure(with textSet: PhaseTextSet?) {
        textLabel.fadeTransition(0.5)
        timerLabel.fadeTransition(0.5)
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
                return 110
            case .small:
                return 50
            case .smallest:
                return 40
            }
        }

        func fontSizes() -> (text: CGFloat, timer: CGFloat) {
            let sizes: (text: DefaultStyle.Font.Size, timer: DefaultStyle.Font.Size)
            switch self {
            case .normal:
                sizes = (Style.Font.Size.large, Style.Font.Size.normal)
            case .small:
                sizes = (Style.Font.Size.normal, Style.Font.Size.small)
            case .smallest:
                sizes = (Style.Font.Size.small, Style.Font.Size.tiny)
            }
            return (sizes.text.rawValue, sizes.timer.rawValue)
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
