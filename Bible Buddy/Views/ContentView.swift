//
//  ContentView.swift
//  ChristeninMuenchen
//
//  Created by admin on 11.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack{
                Divider()
                Spacer()
                mainNavi()
                Spacer()
                HStack(){
                    NavigationLink(destination: RegisterView(), tag:1, selection: self.$selection){
                                   Text("")
                               }
                    NavigationLink(destination: LogInView(), tag:2, selection: self.$selection){
                        Text("")
                    }
                    
                    Button("Register"){
                        self.selection = 1
                    }
                    Spacer()
                    Button("Login"){
                        self.selection = 2
                    }
                        /*Text("Reigster")
                            .font(.system(size: 25, weight: .bold))
                            .padding(10.0)*/
                        /*Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .padding(5.0)*/
                    }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
         

        }
    
        
    }
}
extension UINavigationController{
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .some(UIColor(red: 0.22, green: 0.28, blue: 0.31, alpha: 1.00))
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = standardAppearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*.navigationBarItems(leading:
    HStack(spacing: 190){
        Text("Home")
            .font(.system(size: 35, weight: .bold))
            .padding(5.0)
        Image("people").resizable()
            .frame(width: 80.0, height: 50.0)
            .cornerRadius(8.0)
            .padding(5.0)
})*/
