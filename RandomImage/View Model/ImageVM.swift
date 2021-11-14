//
//  ImageVM.swift
//  Random Image
//
//  Created by Mujahid on 09/11/21.
//

import Foundation
import UIKit

protocol ImageDelegate: AnyObject {
    func reloadUI()
}

class ImageVm {
    weak var delegate: ImageDelegate?
    var image: [ImageArray] = []
    var currentIndex: Int = 0
    var imageRes: ImageResponse? = nil
    var networkManager: ImageVmNetworkManagerProtocol?
    
    init(networkManager: ImageVmNetworkManagerProtocol = ImageVmNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getImage() {
        networkManager?.getImage { response, error in
            if error == nil {
                self.imageRes = response
                print(self.imageRes)
                self.downloadImage(res: response)
            } else {
                debugPrint("Error \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func downloadImage(res: ImageResponse?) {
        networkManager?.downloadImage(url: res?.message) { response, error in
            if error == nil {
                guard let imageData = response else{return}
                self.image.append(ImageArray(name: UIImage(data: imageData, scale:1)))
                DispatchQueue.main.async {
                    self.delegate?.reloadUI()
                }
            }else {
                debugPrint("Error \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
