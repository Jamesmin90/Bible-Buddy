//
//  EventsView.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct EventsView: View {
    
    var body: some View {
        
        VStack(alignment: .center){
            Text("Events")
            
        }
        .navigationBarTitle(Text("Events"), displayMode: .inline)
        
        
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
