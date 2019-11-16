//
//  AIProcessingSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import TinyConstraints
import UIKit

class AIProcessingSceneView: BaseSceneView {

    lazy var safeAreaContainer: UIView = {
        let container = UIView()
        return container
    }()

    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = Style.Font.make(ofSize: .xlarge, weight: .medium)
        return label
    }()

    private lazy var activityIndicatorContainer: UIView = {
        let container = UIView()
        return container
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .gray)
        }
        return indicator
    }()

    override func addViews() {
        super.addViews()

        addSubview(safeAreaContainer)
        addSubview(progressLabel)
        addSubview(activityIndicatorContainer)
        activityIndicatorContainer.addSubview(activityIndicator)
    }

    override func setColors() {
        super.setColors()

        progressLabel.textColor = Style.Color.text
    }

    override func setConstraints() {
        super.setConstraints()

        safeAreaContainer.edgesToSuperview(usingSafeArea: true)

        progressLabel.centerInSuperview()

        activityIndicatorContainer.size(CGSize(width: 50, height: 50))
        activityIndicatorContainer.centerX(to: safeAreaContainer)
        activityIndicatorContainer.bottom(to: safeAreaContainer)

        activityIndicator.centerInSuperview()
    }
}
