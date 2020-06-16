//
//  LoadingView.swift
//  Bible Buddy
//
//  Created by admin on 16.06.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    @State var spin = false
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 0.8470571319)),Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.6007956288))]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 45, height: 45)
                    
                    
                    .rotationEffect(.degrees(spin ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.spin.toggle()
                }
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
