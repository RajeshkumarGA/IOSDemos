//
//  DiscoverViewController.swift
//  Aisle
//
//  Created by RajeshKumar on 04/02/21.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var noteImg1: UIImageView!
    @IBOutlet weak var stackImg1: UIImageView!
    @IBOutlet weak var stackImg2: UIImageView!
    @IBOutlet weak var upgradeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setUpImages()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.setNavigationBarHidden(true, animated: true)
   }
    
    func setUpImages(){
        noteImg1.layer.masksToBounds = true
        noteImg1.layer.cornerRadius = 10
        stackImg1.layer.masksToBounds = true
        stackImg1.layer.cornerRadius = 5
        stackImg1.applyBlurEffect(bgImageView: stackImg1)
        stackImg2.layer.masksToBounds = true
        stackImg2.layer.cornerRadius = 5
        stackImg2.applyBlurEffect(bgImageView: self.stackImg2)
        self.upgradeBtn.layer.cornerRadius = 17.5
        
    }
    
    @IBAction func NotesAction(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

extension UIImageView {
    func applyBlurEffect(bgImageView: UIImageView) {
        let inputImage = CIImage(cgImage: (bgImageView.image?.cgImage)!)
                        let filter = CIFilter(name: "CIGaussianBlur")
                        filter?.setValue(inputImage, forKey: "inputImage")
                        filter?.setValue(10, forKey: "inputRadius")
                        let blurred = filter?.outputImage

                        var newImageSize: CGRect = (blurred?.extent)!
                        newImageSize.origin.x += (newImageSize.size.width - (bgImageView.image?.size.width)!) / 2
                        newImageSize.origin.y += (newImageSize.size.height - (bgImageView.image?.size.height)!) / 2
                        newImageSize.size = (bgImageView.image?.size)!

                        let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
                        let context: CIContext = CIContext.init(options: nil)
                        let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
                        let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
                        bgImageView.image = blurredImage
    }
}
