//
//  MapView.swift
//  Bible Buddy
//
//  Created by James on 22.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @State var latitude : Double
    @State var longitude : Double
    @State var title : String?
    @State var subtitle : String?
    
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        let landmarks = [Landmark(title: self.title, subtitle: self.subtitle, coordinate: coordinate)]
        view.addAnnotations(landmarks)
        
        
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView( latitude: 48.149996544187985, longitude: 11.594266891479492, title: "LMU", subtitle: "Bible Study")
    }
}


