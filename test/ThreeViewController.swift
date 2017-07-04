//
//  ThreeViewController.swift
//  test
//
//  Created by 敬庭超 on 2017/7/4.
//  Copyright © 2017年 敬庭超. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    var circleCenter: CGPoint!
    var circleAnimator: UIViewPropertyAnimator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        circle.center = view.center
        circle.layer.cornerRadius = 50.0
        circle.backgroundColor = UIColor.green
        
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle)))
        
        view.addSubview(circle)
        
        circleAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: { 
            circle.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        })
        circleAnimator?.addAnimations({ 
            circle.backgroundColor  = UIColor.blue
        }, delayFactor: 0.75)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        switch gesture.state {
        case .began:
//            if circleAnimator != nil && circleAnimator!.isRunning {
//                //暂停动画不结束动画
//                circleAnimator?.stopAnimation(false)
//                
//            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
            circleAnimator?.fractionComplete = target.center.y / self.view.frame.height

//        case .ended:
//            /// 获得手势的速度
//            let v = gesture.velocity(in: target)
//            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
//            let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity)
//            circleAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
//            circleAnimator!.addAnimations {
//                target.center = self.view.center
//            }
//            circleAnimator!.startAnimation()
        default:
            break;
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
