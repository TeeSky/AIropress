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

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: AppOptions.fontSize.small, weight: .regular)
        textView.textAlignment = .left
        textView.isScrollEnabled = false

        return textView
    }()

    private lazy var contentContainer: UIView = {
        let container = UIView()
        return container
    }()

    override func addViews() {
        addSubview(contentContainer)

        contentContainer.addSubview(textView)
    }

    override func setConstraints() {
        contentContainer.edgesToSuperview()

        textView.sizeToFit()
        textView.edgesToSuperview()
    }
}
