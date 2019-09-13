//
//  LabeledSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 30/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class LabeledSceneView: BaseSceneView {
    
    lazy var safeAreaContainer: UIView = {
        return UIView()
    }()
    
    lazy var sceneLabelContainer: UIView = {
        let container = UIView()
        
        let label = UILabel()
        label.text = getSceneLabelText()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: AppOptions.fontSize.xlarge, weight: .heavy)
        
        container.addSubview(label)
        label.centerYToSuperview()
        
        return container
    }()
    
    lazy var contentContainer: UIView = {
        return UIView()
    }()
    
    lazy var bottomButtonContainer: UIView = {
        return UIView()
    }()
    
    func getSceneLabelText() -> String {
        fatalError("sceneLabelText function should be overriden.")
    }
    
    override func addViews() {
        addSubview(safeAreaContainer)
        addSubview(sceneLabelContainer)
        addSubview(contentContainer)
        addSubview(bottomButtonContainer)
    }
    
    override func setContraints() {
        safeAreaContainer.edgesToSuperview(insets: TinyEdgeInsets(horizontal: 15), usingSafeArea: true)
        
        sceneLabelContainer.height(120)
        bottomButtonContainer.height(65)
        
        safeAreaContainer.stack([sceneLabelContainer, contentContainer, bottomButtonContainer], axis: .vertical, spacing: 5)
    }
}
