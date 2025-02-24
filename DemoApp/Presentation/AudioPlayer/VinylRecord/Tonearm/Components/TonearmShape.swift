//
//  TonearmShape.swift
//  Demo
//
//  Created by NANG SAN KHAM on 2/18/25.
//

import SwiftUI

/// Custom shape defining the tonearm's organic curvature
struct TonearmShape: Shape {
    // Geometric configuration parameters
    var middleYPosition: CGFloat = 0.8    // Vertical position of middle point (0-1)
    var endPointXOffset: CGFloat = 0.2    // Horizontal offset for endpoint
    var curveControlXOffset: CGFloat = 0.1
    var curveControlYPosition: CGFloat = 0.9
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let top = CGPoint(x: rect.midX, y: rect.minY)
            let mid = CGPoint(x: rect.midX, y: rect.maxY * middleYPosition)
            let bottom = CGPoint(
                x: rect.midX - (rect.width * endPointXOffset),
                y: rect.maxY
            )
            let control = CGPoint(
                x: rect.midX - (rect.width * curveControlXOffset),
                y: rect.maxY * curveControlYPosition
            )
            
            path.move(to: top)
            path.addLine(to: mid)
            path.addQuadCurve(to: bottom, control: control)
        }
    }
}
