//
//  ImageHolder.swift
//  MyKitchen
//
//  Created by Levi Carpenter on 11/7/21.
//

import Foundation
import SwiftUI

class ImageHolder {
    let imgUrl : String
    var img : Image?
    
    init(url: String) {
        imgUrl = url
    }
    
    func getImage() {
        let url = URL(string: self.imgUrl)
        
        _ = URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            self.img = Image(uiImage: UIImage(data: data)!)
        }
    }
}
