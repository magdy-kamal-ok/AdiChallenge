//
//  AdiImageView.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit


fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

class AdiImageView: UIImageView {
    
    var imageUrlString:String?
    
    func loadImageUsingUrlString(urlString:String, placeHolderImage:UIImage?) {
        image = placeHolderImage
        guard let url = URL(string: urlString) else {
            image = nil
            return
        }
        
        imageUrlString = urlString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let _ = error {
                DispatchQueue.main.async {
                    self.image = placeHolderImage
                }
                return
            }
            DispatchQueue.main.async(execute: {
                if let imageToCache = UIImage(data: data!) {
                    imageCache.setObject(imageCache, forKey: urlString as AnyObject)
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                }
                else {
                    self.image = placeHolderImage
                }
            })
        }.resume()
    }
}
