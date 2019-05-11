//
//  JustifyView.swift
//  JustifyView
//
//  Created by Ahmed Khalaf on 5/11/19.
//  Copyright © 2019 Ahmed Khalaf. All rights reserved.
//

import UIKit

fileprivate let VIEW_HEIGHT: CGFloat = 44

fileprivate func makeView(ofWidth width: CGFloat, in superview: UIView) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: VIEW_HEIGHT))
    view.backgroundColor = .green
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.black.cgColor
    superview.addSubview(view)
    return view
}

class JustifyView: UIView {
    private lazy var views: [UIView] = (0..<30).lazy.map({ _ in return makeView(ofWidth: CGFloat.random(in: 10...100), in: self) })
    
    override func layoutSubviews() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lastLine: [UIView] = []
        
        for view in views {
            if x + view.bounds.width > bounds.width {
                justify(lastLine)
                lastLine = []
                x = 0
                y += VIEW_HEIGHT
            }
            
            var frame = view.frame
            frame.origin = CGPoint(x: x, y: y)
            view.frame = frame
            x += view.bounds.width
            lastLine.append(view)
        }
        
        alignLeft(lastLine)
    }
}

fileprivate extension JustifyView {
    func justify(_ views: [UIView]) {
        guard views.count > 1 else { return }
        
        let spacePerItem = (bounds.width - views.map({ $0.bounds.width }).reduce(0, +)) / CGFloat(views.count - 1)
        
        var x = views[1].frame.origin.x + spacePerItem
        for i in 1..<views.count {
            var frame = views[i].frame
            frame.origin.x = x
            views[i].frame = frame
            x += frame.width + spacePerItem
        }
    }
    
    func alignLeft(_ views: [UIView]) {
        var x: CGFloat = 0
        for view in views {
            var frame = view.frame
            frame.origin.x = x
            view.frame = frame
            x += frame.width
        }
    }
}
