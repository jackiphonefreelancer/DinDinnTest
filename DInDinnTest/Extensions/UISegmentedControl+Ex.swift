//
//  UISegmentedControl+Ex.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import UIKit

extension UISegmentedControl {
    func applyDefaultStyle() {
        setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)], for: .selected)
        setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)], for: .normal)
        
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        layer.cornerRadius = 20.0
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layoutIfNeeded()
    }
}
