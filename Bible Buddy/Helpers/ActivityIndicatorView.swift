//
//  ActivityIndicatorView.swift
//  Bible Buddy
//
//  Created by admin on 28.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//
/*
import SwiftUI

struct ActivityIndicatorView: View{
    @State var animating = false
    @State var animate =  false
    
    var body: some View{
        
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors: [.orange,.red]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 45, height:45)
                .rotationEffect(.init(degrees: self.animating ? 360:0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }
        .onAppear{
            if self.animate == true {
                self.animating.toggle()
            }else {
                return }
        }
        
    }
}
 */

/*
struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(animate: true)
    }
}
*/









import Foundation
import SwiftUI




struct ActivitiyIndicatorView: UIViewRepresentable {
    
    @Binding var loading: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        //var color = UIColor(red: 0.22, green: 0.28, blue: 0.31, alpha: 1.00)
        let indicator = UIActivityIndicatorView(style: style)
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        loading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

