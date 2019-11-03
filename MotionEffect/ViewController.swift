//
//  ViewController.swift
//  MotionEffect
//
//  Created by Training on 15/08/16.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var lottieAnimationView: LottieView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var soundAlert = Bundle.main.path(forResource: "", ofType: "mp3")
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("App started in viewController")
        
        applyMotionEffect(toView: backgroundImageView, magnitude: 100)
    
        
        if let animationView = LOTAnimationView(name: "forest") {
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            
            view.addSubview(animationView)
        
            animationView.play()
        }
        
    }
    
    
    func playSound(name: String)
    {
        soundAlert = Bundle.main.path(forResource: name, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundAlert!))
            audioPlayer.play()
        } catch {
            print("couldn't load sound file")
        }
    }
    
    
    func applyMotionEffect (toView view:UIView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func otherBtn(_ sender: Any) {
        playSound(name: "cardoor")
    }
    
    @IBAction func btn(_ sender: Any) {
        playSound(name: "carAlertSound")
    }
}

