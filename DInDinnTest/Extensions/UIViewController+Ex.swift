//
//  UIViewController+Ex.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

// MARK: - Become Root
extension UIViewController {
    func becomeRoot() {
        UIApplication.shared.keyWindow?.rootViewController = self
    }
}

// MARK: - Error Dialog
extension UIViewController {
    @discardableResult
    func alert(title: String? = nil, message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    @discardableResult
    func showGeneralError() -> UIAlertController {
        return alert(title: "something went wrong!", message: nil)
    }
}

// MARK: - Loading Dialog
extension UIViewController {
    func showLoadingOverlay() {
        LoadingOverlay.shared.showLoading(in: self)
    }
    
    func hideLoadingOverlay() {
        LoadingOverlay.shared.hideLoading()
    }
}
