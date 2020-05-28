//
//  Artwork.swift
//  Bible Buddy
//
//  Created by admin on 22.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import Foundation
import MapKit

class Landmark: NSObject, MKAnnotation {
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

  }

    static func requestMockData()-> [Landmark]{
        return [
            Landmark(title: "LMU", subtitle: "Bible Study", coordinate: .init(latitude: 48.149996544187985, longitude: 11.594266891479492))
        ]
    }
}

