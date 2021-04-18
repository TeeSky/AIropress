//
//  BrewingSceneView.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 14.04.2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import SnapKit
import UIKit

final class BrewingSceneView: BaseSceneView {

    let mainTimerLabel = UILabel(font: .systemFont(ofSize: 47, weight: .medium))

    let currentPhaseTimerLabel = PhaseLabelView(scale: .normal)
    let next1TimerLabel = PhaseLabelView(scale: .small)
    let next2TimerLabel = PhaseLabelView(scale: .smallest)

    let stopButton = BaseSceneView.createNegativeButton(title: "Stop")

    private lazy var phaseLabelsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [currentPhaseTimerLabel, next1TimerLabel, next2TimerLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()

    override func addViews() {
        super.addViews()

        addSubviews(mainTimerLabel, phaseLabelsStackView, stopButton)
    }

    override func setColors() {
        super.setColors()

        mainTimerLabel.textColor = Style.Color.text
    }

    override func setConstraints() {

        let mainTimerLabelTopOffset = 90
        mainTimerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(mainTimerLabelTopOffset)
        }

        let phaseLabelSideInset = 24
        phaseLabelsStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(phaseLabelSideInset)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(phaseLabelSideInset)
            make.centerY.equalTo(snp.centerY)
        }

        let buttonSideInset = 12
        stopButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(buttonSideInset)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(buttonSideInset)
        }
    }
}
