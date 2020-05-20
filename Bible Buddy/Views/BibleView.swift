//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleView: View {
    var body: some View {
        
        VStack(alignment: .center){
            Text("Bible")
            
        }
        .navigationBarTitle(Text("Bible"), displayMode: .inline)
    }
    
}

struct BibleView_Previews: PreviewProvider {
    static var previews: some View {
        BibleView()
    }
}
