//
//  PhaseLabelView.swift
//  AIropress
//
//  Created by Tomáš Skýpala on 14.04.2021.
//  Copyright © 2021 Tomas Skypala. All rights reserved.
//

import UIKit

final class PhaseLabelView: UIView {

    var textLabel: UILabel!
    var timerLabel: UILabel!

    convenience init(scale: Scale) {
        self.init()

        setScale(scale: scale)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViews()
        setConstraints()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        textLabel.textColor = Style.Color.text
        timerLabel.textColor = Style.Color.text
    }

    private func addViews() {
        textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.lineBreakMode = .byTruncatingTail

        timerLabel = UILabel()
        timerLabel.alpha = 0.6
        timerLabel.textAlignment = .right

        addSubview(textLabel)
        addSubview(timerLabel)
    }

    private func setConstraints() {
        timerLabel.width(75)

        textLabel.edgesToSuperview(excluding: .bottom)

        timerLabel.bottomToSuperview()
        timerLabel.rightToSuperview()

//        textLabel.rightToLeft(of: timerLabel, offset: -15, relation: .equalOrLess, priority: .required)
    }

    func setScale(scale: Scale) {
        textLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().text)
        timerLabel.font = UIFont.systemFont(ofSize: scale.fontSizes().timer)

        alpha = scale.alpha()
        height(scale.height())
        textLabel.bottomToSuperview(offset: -scale.fontSizes().timer)
    }

    func configure(with textSet: PhaseTextSet?) {
        textLabel.fadeTransition(0.5)
        timerLabel.fadeTransition(0.5)
        if let textSet = textSet {
            textLabel.text = textSet.labelText
            timerLabel.text = textSet.timerText
        } else {
            textLabel.text = ""
            timerLabel.text = ""
        }
    }

    enum Scale {
        case normal
        case small
        case smallest

        func height() -> CGFloat {
            switch self {
            case .normal:
                return 110
            case .small:
                return 50
            case .smallest:
                return 40
            }
        }

        func fontSizes() -> (text: CGFloat, timer: CGFloat) {
            let sizes: (text: DefaultStyle.Font.Size, timer: DefaultStyle.Font.Size)
            switch self {
            case .normal:
                sizes = (Style.Font.Size.large, Style.Font.Size.normal)
            case .small:
                sizes = (Style.Font.Size.normal, Style.Font.Size.small)
            case .smallest:
                sizes = (Style.Font.Size.small, Style.Font.Size.tiny)
            }
            return (sizes.text.rawValue, sizes.timer.rawValue)
        }

        func alpha() -> CGFloat {
            switch self {
            case .normal:
                return 1
            case .small:
                return 0.7
            case .smallest:
                return 0.4
            }
        }
    }
}
