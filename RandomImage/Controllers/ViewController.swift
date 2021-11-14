//
//  ViewController.swift
//  Random Image
//
//  Created by Mujahid on 09/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var vm: ImageVm? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        DispatchQueue.global().async {
            self.vm?.getImage()
        }
    }
    
    func setup(viewModel: ImageVm = ImageVm()) {
        self.vm = viewModel
        vm?.delegate = self
    }
    
    func setUI() {
        prevBtnHandling()
        if let img = vm?.image.last {
            ivImage.image = img.name
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        switch sender {
        case btnPrev:
            vm?.image.removeLast()
            DispatchQueue.main.async {
                self.setUI()
            }
        case btnNext:
            prevBtnHandling()
            DispatchQueue.global().async {
                self.vm?.getImage()
            }
        default:
            break
        }
    }
    
    func prevBtnHandling() {
        if let imgArray = vm?.image, imgArray.count <= 1 {
            btnPrev.isHidden = true
        } else {
            btnPrev.isHidden = false
        }
    }
}

extension ViewController: ImageDelegate {
    func reloadUI() {
        setUI()
    }
}

