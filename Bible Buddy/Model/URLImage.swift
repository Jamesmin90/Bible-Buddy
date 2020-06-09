//
//  URLImage.swift
//  Bible Buddy
//
//  Created by jag on 05.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import Combine

class URLImage: ObservableObject {

    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()

    }
}
