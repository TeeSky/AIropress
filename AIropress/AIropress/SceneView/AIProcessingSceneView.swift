//
//  AIProcessingSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 21/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class AIProcessingSceneView: BaseSceneView {
    
    lazy var safeAreaContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.xlarge, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var activityIndicatorContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        return indicator
    }()
    
    override func addViews() {
        addSubview(safeAreaContainer)
        addSubview(progressLabel)
        addSubview(activityIndicatorContainer)
        activityIndicatorContainer.addSubview(activityIndicator)
    }
    
    override func setContraints() {
        safeAreaContainer.edgesToSuperview(usingSafeArea: true)
        
        progressLabel.centerInSuperview()
        
        activityIndicatorContainer.size(CGSize(width: 50, height: 50))
        activityIndicatorContainer.centerX(to: safeAreaContainer)
        activityIndicatorContainer.bottom(to: safeAreaContainer)
        
        activityIndicator.centerInSuperview()
    }
}
