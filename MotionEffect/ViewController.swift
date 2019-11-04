//
//  ViewController.swift
//  MotionEffect
//
//  Created by Training on 15/08/16.
//  Copyright © 2016 Training. All rights reserved.
//

import UIKit
import AVFoundation

struct JsonResponse: Codable {
    let Response: ResponseData
}

struct ResponseData: Codable {
    let View: [ViewData]
}

struct ViewData: Codable {
    let Result: [ResultData]
}

struct ResultData: Codable {
    let Location: LocationData
}

struct LocationData: Codable{
    let LinkInfo: LinkInfo
}

struct LinkInfo: Codable{
    let SpeedCategory: String
}

class ViewController: UIViewController {
    
    var lockStatus: Bool = true

    @IBOutlet weak var lockStatusLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBAction func lockBtn(_ sender: UIButton) {
        
        if lockStatus {
            if #available(iOS 13.0, *) { sender.setBackgroundImage(UIImage(systemName: "lock.open"), for: .normal)
                lockStatus.toggle()
                playSound(name: "unlock")
                lockStatusLabel.text = "Unlocked"
            } else {
                // Fallback on earlier versions
            }
        }
        else {
            if #available(iOS 13.0, *) { sender.setBackgroundImage(UIImage(systemName: "lock"), for: .normal)
                lockStatus.toggle()
                playSound(name: "lock")
                lockStatusLabel.text = " Locked "
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    var soundAlert = Bundle.main.path(forResource: "", ofType: "mp3")
    var audioPlayer: AVAudioPlayer!
    
    var speed: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("App started in viewController")
        
//        //city
//        updateSppedLimit(latitude: -37.815435, longitude: 144.953799)
//
//        //northroad
//        updateSppedLimit(latitude: -37.910743, longitude: 145.096523)
//        
//        //gaddStreet
//        updateSppedLimit(latitude: -37.909896, longitude: 145.096834)
//
//        //monash freeway
//        updateSppedLimit(latitude: -37.868422, longitude: 145.063092)
        

        
        applyMotionEffect(toView: backgroundImageView, magnitude: 50)
        
    }
    
    func updateSppedLimit(latitude: Double, longitude: Double)
    {
        let lat = String(format: "%f", latitude)
        let lon = String(format: "%f", longitude)
        
        let url = URL(string: "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox="+lat+","+lon+",50&mode=retrieveAddresses&locationAttributes=linkInfo&gen=9&app_id=bGsxRlcLJl9jlkPw8llT&app_code=P61HIba-X4DxDhv2SypcFg")
        
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let data = data {
                let resp = try? JSONDecoder().decode(JsonResponse.self, from: data)
                self.speed = (resp?.Response.View.first?.Result.first?.Location.LinkInfo.SpeedCategory)!
                print(self.speed!)
                print("Speed retrieved")
                self.displaySpeedLimit()
            }
        }.resume()
    }
    
    
    func playSound(name: String) {
        soundAlert = Bundle.main.path(forResource: name, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundAlert!))
            audioPlayer.play()
        } catch {
            print("couldn't load sound file")
        }
    }
    
    func displaySpeedLimit() {
        if speed == "SC1"{
            print(">130")
        }
        else if speed == "SC2"{
            print("130")
        }
        else if speed == "SC3"{
            print("100")
        }
        else if speed == "SC4"{
            print("90")
        }
        else if speed == "SC5"{
            print("70")
        }
        else if speed == "SC6"{
            print("50")
        }
        else if speed == "SC7"{
            print("30")
        }
        else if speed == "SC8"{
            print("<11")
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

