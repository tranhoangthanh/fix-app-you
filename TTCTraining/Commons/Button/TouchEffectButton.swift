//
//  TouchEffectButton.swift
//  TTCTraining
//
//  Created by Bui Tam on 8/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TouchEffectButton: UIButton {

    var touchLayers = [UITouch:CALayer]()
        var currentAnimIndex: Int = 0
        var animIndices: [Int] = []
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            animIndices.append(currentAnimIndex)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                // add new layer to button
                let newLayer = CALayer()
                newLayer.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.9).cgColor
                newLayer.cornerRadius = bounds.height/2
                newLayer.frame = CGRect(x: touch.location(in: self).x - self.bounds.height/2, y: touch.location(in: self).y - self.bounds.height/2, width: self.bounds.height, height: self.bounds.height)
                self.layer.addSublayer(newLayer)
                self.layer.setNeedsLayout()
                touchLayers[touch] = newLayer
                
                // setup scale animation
                let anim: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                anim.fromValue = NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
                let scaleValue = self.bounds.width*4/5/self.bounds.height
                anim.toValue = NSValue.init(caTransform3D: CATransform3DMakeScale(scaleValue, scaleValue, 1.0))
                print("Scale value = \(scaleValue)")
                
                // keep UI not reset to init value
                anim.fillMode = CAMediaTimingFillMode.forwards
                anim.isRemovedOnCompletion = false
                
                // set duration for animation
                anim.duration = 0.6
                newLayer.add(anim, forKey: nil)
            }
            super.touchesBegan(touches, with: event)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let anim: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
                anim.fromValue = 1.0
                anim.toValue = 0.0
                anim.duration = 1
                anim.fillMode = CAMediaTimingFillMode.forwards
                anim.isRemovedOnCompletion = false
                anim.delegate = self
                if let layer = touchLayers[touch] {
                    //            animIndices.append(animIndices.count)
                    layer.add(anim, forKey: "\(currentAnimIndex)")
                    anim.setValue(layer, forKey: "\(currentAnimIndex)")
                    currentAnimIndex += 1
                    animIndices.append(currentAnimIndex)
                }
            }
            super.touchesEnded(touches, with: event)
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let anim: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
                anim.fromValue = 1.0
                anim.toValue = 0.0
                anim.duration = 1
                anim.fillMode = CAMediaTimingFillMode.forwards
                anim.isRemovedOnCompletion = false
                anim.delegate = self
                if let layer = touchLayers[touch] {
                    //            animIndices.append(animIndices.count)
                    layer.add(anim, forKey: "\(currentAnimIndex)")
                    anim.setValue(layer, forKey: "\(currentAnimIndex)")
                    currentAnimIndex += 1
                    animIndices.append(currentAnimIndex)
                }
            }
            super.touchesEnded(touches, with: event)
            
        }
    }

    extension TouchEffectButton: CAAnimationDelegate {
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            for index in animIndices {
                if let layer = anim.value(forKey: "\(index)") as? CALayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
    }

