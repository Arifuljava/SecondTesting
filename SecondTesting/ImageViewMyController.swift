//
//  ImageViewMyController.swift
//  SecondTesting
//
//  Created by sang on 23/5/23.
//

import UIKit

class ImageViewMyController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "demo") {
            // Use the image here
            // For example, assign it to an image view
            imageview.image = image
        } else {
            // Unable to find the image in the asset catalog
            // Handle the error or provide a fallback image
        }
    }

}
