//
//  BaseSceneView.swift
//  AIropress
//
//  Created by Tomas Skypala on 19/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BaseSceneView: UIView {
    
    func render() {
        self.backgroundColor = .white
        
        self.addViews()
        self.setContraints()
    }
    
    func addViews() {
    }
    
    func setContraints() {
    }
}
