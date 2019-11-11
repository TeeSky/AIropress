//
//  BaseTableViewCell.swift
//  AIropress
//
//  Created by Tomas Skypala on 23/08/2019.
//  Copyright © 2019 Tomas Skypala. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell<CV: BaseCellView>: UITableViewCell {

    var didSetConstraints = false

    var cellView: CV

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellView = CV()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellView.addViews()
        self.contentView.addSubview(cellView)
        self.contentView.backgroundColor = Style.Color.background
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        if !didSetConstraints {
            cellView.edgesToSuperview()
            cellView.setConstraints()
            didSetConstraints = true
        }

        super.updateConstraints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.contentView.backgroundColor = Style.Color.background
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cellView.prepareForReuse()
    }
}
