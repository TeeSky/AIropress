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
