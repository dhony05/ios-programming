//
//  GraphView.swift
//  Test
//
//  Created by Sameh Fakhouri on 11/2/17.
//  Copyright © 2017 Sameh. All rights reserved.
//

import UIKit

class GraphView: UIView {


    var scale: CGFloat = 50.0 { didSet { setNeedsDisplay() } }
    
    var color = UIColor.blue { didSet { setNeedsDisplay() } }
    
    var originLocation = CGPoint.zero
    
    
    func graphCenter() -> CGPoint {
        return convert(center, from: superview)
    }
    
    func findOrigin() -> CGPoint {
        var origin = originLocation
        origin.x += graphCenter().x
        origin.y += graphCenter().y
        return origin
    }
    
    var axesDrawer = AxesDrawer()
    
    override func draw(_ rect: CGRect) {
        axesDrawer.color = color
        axesDrawer.contentScaleFactor = scale
        axesDrawer.drawAxes(in: self.bounds, origin: findOrigin(), pointsPerUnit: scale)
    }

}
