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
    
}

