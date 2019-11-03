//
//  DriverViewController.swift
//  MotionEffect
//
//  Created by Sai Raghu Varma Kallepalli on 2/11/19.
//  Copyright © 2019 Training. All rights reserved.
//

import UIKit
import LocalAuthentication

class DriverViewController: UIViewController {
    
    var context = LAContext()
    
    var error: NSError?
    var loginStatus = false

    override func viewDidLoad() {
        super.viewDidLoad()
        FaceId()
        // Do any additional setup after loading the view.
    }
    
    func FaceId()
    {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your Profile"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                if success {
                    print("success")
                }
                else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
        
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
