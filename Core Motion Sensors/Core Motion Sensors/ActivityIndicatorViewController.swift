//
//  ActivityIndicatorViewController.swift
//  Core Motion Sensors
//
//  Created by RajeshKumar on 13/02/21.
//

import UIKit
import CoreMotion

class ActivityIndicatorViewController: UIViewController {
    
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var activityIndicatorText: UILabel!
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator()
        self.pedoMeterStepCounter()

        // Do any additional setup after loading the view.
    }
    
    func activityIndicator(){
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: OperationQueue.main){(data) in
                DispatchQueue.main.async {
                    if let activity = data{
                        if activity.running == true{
                            print("Running")
                            self.activityIndicatorText.text = "Running"
                        }else if activity.cycling == true{
                            print("Cycling")
                            self.activityIndicatorText.text = "Cycling"
                        }else if activity.stationary == true{
                            print("Stationary")
                            self.activityIndicatorText.text = "Stationary"
                        }else if activity.automotive == true{
                            print("Driving")
                            self.activityIndicatorText.text = "Driving"
                        }else if activity.walking == true{
                            print("Walking")
                            self.activityIndicatorText.text = "Walking"
                        }else if activity.unknown == true{
                            print("unknown")
                            self.activityIndicatorText.text = "Unknown"
                        }else{
                            print("error")
                        }
                    }
                }
                
            }
        }
    }
    
    func pedoMeterStepCounter(){
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            var todaysSteps = 0
            self.pedoMeter.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
                print(data?.numberOfSteps)
                if let steps = data?.numberOfSteps{
                    DispatchQueue.main.async {
                        todaysSteps = Int(steps)
                        self.steps.text = "\(todaysSteps)"
                    }
                }
            }
            
            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
                print(data?.numberOfSteps)
                if let steps = data?.numberOfSteps{
                    DispatchQueue.main.async {
                        self.steps.text = "\(Int(steps) + todaysSteps)"
                    }
                }
            }
            
        }
        
    }
    
    func getTodaysTotalSteps()->Int{
        let calendar = Calendar.current
        var todaysSteps = 0
        self.pedoMeter.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
            print(data?.numberOfSteps)
            if let steps = data?.numberOfSteps{
                DispatchQueue.main.async {
                    todaysSteps = Int(steps)
                }
            }
        }
        return todaysSteps
    }
}
