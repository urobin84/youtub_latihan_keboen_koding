//
//  Extensions.swift
//  YoutubeMQR
//
//  Created by Pungs on 28/02/19.
//  Copyright © 2019 Pungs. All rights reserved.
//

import UIKit

extension UIView{
    func addConstraintWithFormat(format: String, views: UIView...){
        var viewDirectory = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDirectory[key] = view
        }
        addConstraints( NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDirectory))
    }
}


extension UIImageView {
    func loadImageUsingUrlString(urlString: String){
        guard let url = URL(string: urlString) else {return}
    
        let session = URLSession.shared
    
        session.dataTask(with: url) { (data, response, error) in
        if response != nil {
        //                print(response as Any)
        }
        if error != nil {
        print(error as Any)
        return
        }
        DispatchQueue.main.async {
        self.image = UIImage(data: data!)
        }
    
        }.resume()
    }
}

