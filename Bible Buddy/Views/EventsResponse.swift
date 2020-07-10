//
//  EventsResponse.swift
//  Bible Buddy
//
//  Created by James on 08.07.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import Firebase

struct EventsResponse: View {
    var postName : String
    var height: CGFloat
    var icount: String
    var bcount: String
    
    var body: some View {
        
            
        VStack(alignment: .center){
                Text("Responses")
                    .font(.headline)
                Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Interessiert")
                    Text(icount)
                }
                Spacer()
                VStack{
                    Text("Besuchen")
                    Text(bcount)
                }
                Spacer()
            }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: self.height)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
                
            
        
    }

}

    


