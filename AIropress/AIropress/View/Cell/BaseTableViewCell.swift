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

    open var contentBackgroundColor: UIColor = Style.Color.background

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        cellView = CV()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellView.addViews()
        self.contentView.addSubview(cellView)
        self.contentView.backgroundColor = contentBackgroundColor
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

    override func prepareForReuse() {
        super.prepareForReuse()

        cellView.prepareForReuse()
    }
}
