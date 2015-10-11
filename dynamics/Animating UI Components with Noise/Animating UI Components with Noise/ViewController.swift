//
//  ViewController.swift
//  Animating UI Components with Noise
//
//  Created by Vandad on 8/18/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import SharedCode

class ViewController: UIViewController {
  
  @IBOutlet var orangeView: UIView!
  
  lazy var animator: UIDynamicAnimator = {
    let animator = UIDynamicAnimator(referenceView: self.view)
    animator.debugEnabled = true
    return animator
    }()
  
  lazy var collision: UICollisionBehavior = {
    let collision = UICollisionBehavior(items: [self.orangeView])
    collision.translatesReferenceBoundsIntoBoundary = true
    return collision
    }()
  
  lazy var noise: UIFieldBehavior = {
    let noise = UIFieldBehavior.noiseFieldWithSmoothness(0.9,
      animationSpeed: 1)
    noise.addItem(self.orangeView)
    return noise
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    animator.addBehavior(collision)
    animator.addBehavior(noise)
  }
  
  @IBAction func panning(sender: UIPanGestureRecognizer) {
    
    switch sender.state{
    case .Began:
      collision.removeItem(orangeView)
      noise.removeItem(orangeView)
    case .Changed:
      orangeView.center = sender.locationInView(view)
    case .Ended, .Cancelled:
      collision.addItem(orangeView)
      noise.addItem(orangeView)
    default: ()
    }
    
  }
  
}

