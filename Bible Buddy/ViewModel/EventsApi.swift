//
//  EventsApi.swift
//  Bible Buddy
//
//  Created by James on 29.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

class Api {
    
    //"completion" returns values for this function
    func getPosts(completion: @escaping ([EventsPost]) -> ()) {
        guard let url = URL(string: "https://bible-buddy-3cc17.firebaseio.com/events/.json") else {return}
        //make the API call, and allows to set names of data that we get back from the response.
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([EventsPost].self, from: data!)
            

            
            DispatchQueue.main.async{
                completion(posts)
            }

            
        }
    // for our URLsession call
    .resume()
    }
}

