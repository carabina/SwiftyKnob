//
//  Knob.swift
//  SwiftyKnob
//
//  Created by Jevin Sewaruth on 08/05/2017.
//  Copyright © 2017 Jevin Sew. All rights reserved.
//

import UIKit

class Knob: UIView {
    // Mark: Properties
    var borderWidth: CGFloat = 20
    var borderColor: UIColor = UIColor.lightGray
    var value: Double = 0.78
    var text: String = "78%"
    var descriptionString: String = "retention"
    
    // Mark: Global properties
    var circle: CAShapeLayer!
    var textLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeView()
    }
    
    init(frame: CGRect, borderWidth: CGFloat, borderColor: UIColor, value: Double, text: String, description: String) {
        super.init(frame: frame)
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.value = value
        self.text = text
        self.descriptionString = description

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializeView()
    }
    
    override func draw(_ rect: CGRect) {
        let width = frame.width
        let height = frame.height
        let startAngle = 0.7
        let travelAngle = 1.6
        let endAngle = startAngle + (travelAngle * value)
        
        circle = CAShapeLayer()
        circle.path = UIBezierPath(arcCenter: CGPoint(x: width / CGFloat(2), y: height / CGFloat(2)), radius: (width / CGFloat(2)) - borderWidth, startAngle: CGFloat(Double.pi * startAngle), endAngle: CGFloat(Double.pi * endAngle), clockwise: true).cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = borderColor.cgColor
        circle.lineWidth = borderWidth
        
        circle.strokeEnd = 0
        
        layer.addSublayer(circle)
    }
    
    func initializeView() {
        guard value >= 0.0 && value <= 1.0 else {
            fatalError("Value has to be between 0.0 and 1.0")
        }
        
        self.backgroundColor = UIColor.clear
        
        textLabel = UILabel()
        textLabel.text = text
        textLabel.textColor = UIColor.darkGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        self.addSubview(textLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = text
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Helvetica", size: 12)
        self.addSubview(descriptionLabel)
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 0.5
        
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        resizeLabels()
        circle.strokeEnd = 1
        circle.add(animation, forKey: "animate")
    }
    
    func resizeLabels() {
        var textLabelFrame = textLabel.frame
        textLabelFrame.size.width = self.frame.width
        textLabelFrame.origin.y = (self.frame.height - textLabelFrame.height) / 2
        textLabel.frame = textLabelFrame
        
        var descriptionLabelFrame = descriptionLabel.frame
        descriptionLabelFrame.size.width = self.frame.width
        descriptionLabelFrame.origin.y = ((self.frame.height - descriptionLabelFrame.height) / 4) * 3
        descriptionLabel.frame = textLabelFrame
    }
}
