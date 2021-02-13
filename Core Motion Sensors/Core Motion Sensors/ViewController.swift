//
//  ViewController.swift
//  Core Motion Sensors
//
//  Created by RajeshKumar on 13/02/21.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var accX: UITextField!
    @IBOutlet weak var accY: UITextField!
    @IBOutlet weak var accZ: UITextField!
    var motion = CMMotionManager()
    
    @IBOutlet weak var GroX: UITextField!
    @IBOutlet weak var GroY: UITextField!
    @IBOutlet weak var GroZ: UITextField!
    
    @IBOutlet weak var MagX: UITextField!
    @IBOutlet weak var MagY: UITextField!
    @IBOutlet weak var MagZ: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accelarationData()
        gyroData()
        magnetoData()
        // Do any additional setup after loading the view.
    }
    
    func accelarationData(){
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to : OperationQueue.current! ){ (data,error) in
//            print(data as Any)
            if let trueData = data{
                self.view.reloadInputViews()
                self.accX.text = "X : \(trueData.acceleration.x)"
                self.accY.text = "Y : \(trueData.acceleration.y)"
                self.accZ.text = "Z : \(trueData.acceleration.z)"
            }
        }
    }
    
    func gyroData(){
        motion.gyroUpdateInterval = 0.5
        motion.startGyroUpdates(to : OperationQueue.current!){(data, error) in
//            print(data as Any)
            if let trueData = data{
                self.view.reloadInputViews()
                self.GroX.text = "X : \(trueData.rotationRate.x)"
                self.GroY.text = "Y : \(trueData.rotationRate.y)"
                self.GroZ.text = "Z : \(trueData.rotationRate.z)"
            }
        }
    }
    
    func magnetoData(){
        motion.magnetometerUpdateInterval = 0.5
        motion.startMagnetometerUpdates(to : OperationQueue.current!){(data,error) in
//            print(data as Any)
            if let trueData = data{
                self.view.reloadInputViews()
                self.MagX.text = "X : \(trueData.magneticField.x)"
                self.MagY.text = "Y : \(trueData.magneticField.y)"
                self.MagZ.text = "Z : \(trueData.magneticField.z)"
            }
            
        }
    }


}

