//
//  ImageLoader.swift
//  Bible Buddy
//
//  Created by James on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var downloadImage: UIImage?
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet{
            didChange.send(data)
        }
    }
    init(imageUrl: String) {
        //fetch image data and then call didChange
        guard let url = URL(string: imageUrl) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{
                fatalError("error reading the image")
            }
            DispatchQueue.main.async {
                self.data = data
                self.downloadImage = UIImage(data: data)
            }
        }.resume()
    }
}


