//
//  NibInstanceable.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

protocol NibInstanceable {
    static func nibName() -> String
}

extension NibInstanceable where Self: UIView {
    static func nibInstance() -> Self {
        return Bundle.main.loadNibNamed(Self.nibName(), owner: nil, options: nil)?.first as! Self
    }
}

extension NibInstanceable {
    static func nib(inBundle bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: nibName(), bundle: bundle)
    }
}
