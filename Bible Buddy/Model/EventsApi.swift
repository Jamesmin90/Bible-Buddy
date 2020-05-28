//
//  Data.swift
//  Bible Buddy
//
//  Created by admin on 27.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable{
    let id = UUID()
    var name: String
    var location: String
    var date: String
    var imageURL: String
    var description: String
    var signup: String
    //var geo: Double
}

class Api {
    //"completion" returns values for this function
    func gePosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://bible-buddy-3cc17.firebaseio.com/events/.json") else {return}
        //make the API call, and allows to set names of data that we get back from the response.
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async{
                completion(posts)
                
            }

            
        }
    // for our URLsession call
    .resume()
    }
}

