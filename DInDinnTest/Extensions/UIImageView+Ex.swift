//
//  UIImageView+Ex.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        //contentMode = mode
        // check if you can find url in cache
        if (imageCache.object(forKey: url.absoluteString as String as AnyObject) != nil) {
            self.image = imageCache.object(forKey: url.absoluteString as AnyObject)
        }
        else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                    self.image = image
                }
                }.resume()
        }
        
    }
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let urlString = link else { return }
        guard let url = URL(string: urlString) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
