//
//  ViewController.swift
//  test
//
//  Created by 敬庭超 on 2017/7/3.
//  Copyright © 2017年 敬庭超. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // MARK : private properties
    var circleCenter: CGPoint!
    let animationDuration = 4.0
    var circleAnimator: UIViewPropertyAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        
        circle.center = self.view.center
        
        circle.layer.cornerRadius = 50.0
        
        circle.backgroundColor = UIColor.green
        
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
        

//        circleAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut, animations: {
//            [unowned circle] in
//            circle.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//        })
        circleAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
        
        

        
        view.addSubview(circle)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

typealias privateMethods = ViewController
private extension  privateMethods{
    @objc func dragCircle(gesture: UIPanGestureRecognizer)  {
        let target = gesture.view!
        switch gesture.state {
        case .began, .ended:
//            circleCenter = target.center
//            if circleAnimator.isRunning {
//                circleAnimator.pauseAnimation()
//                circleAnimator.isReversed = gesture.state == .ended
//            }
//            circleAnimator.startAnimation()
            circleCenter = target.center
            
            let durationFactor = circleAnimator.fractionComplete
            circleAnimator.stopAnimation(false)
            circleAnimator.finishAnimation(at: .current)
            /**
             *  无论是手势的开始还是结果，当出现手势状态的时候，就先执行动画的停止
             *
             */
//            if circleAnimator.state == .active {
//                circleAnimator.stopAnimation(true)
//            }
            if gesture.state == .began {
                circleAnimator.addAnimations {
                    target.backgroundColor = UIColor.green
                    target.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                }
            }else{
                circleAnimator.addAnimations {
                    target.backgroundColor = UIColor.red
                    target.transform = CGAffineTransform.identity
                }
            }
            circleAnimator.startAnimation()
//            circleAnimator.pauseAnimation()
            circleAnimator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
        case .changed:
            let translation = gesture.translation(in: self.view)
            //在这个手势移动的过程当中，更改target的center值
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
        default:
            break
        }
    }
}

