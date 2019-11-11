//
//  PrepStepCellView.swift
//  AIropress
//
//  Created by Tomas Skypala on 04/09/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PrepStepCellView: BaseCellView {

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = Style.Font.make(ofSize: .small)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var contentContainer: UIView = {
        let container = UIView()
        return container
    }()

    override func addViews() {
        addSubview(contentContainer)

        contentContainer.addSubview(label)
    }

    override func setConstraints() {
        contentContainer.edgesToSuperview()

        label.edgesToSuperview()
    }
}
