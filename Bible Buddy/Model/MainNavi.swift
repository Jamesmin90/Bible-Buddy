//
//  MainNavi.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import SwiftUI

struct mainNavi: View {
    @State private var selection: Int? = nil
    var body: some View {
        HStack(){
            NavigationLink(destination: EventsView(), tag:1, selection: self.$selection){
                Text("")
            }
            NavigationLink(destination: BibleView(), tag:2, selection: self.$selection){
                Text("")
            }
            NavigationLink(destination: BlogView(), tag:3, selection: self.$selection){
                Text("")
            }
            
            Button("Events"){
                self.selection = 1
            }
            Button("Bible"){
                self.selection = 2
            }
            Button("Blog"){
                self.selection = 3
            }
            Button("Audio"){
                self.selection = 4
            }
        }
    }
}
