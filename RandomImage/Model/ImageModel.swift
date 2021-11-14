//
//  ImageModel.swift
//  Random Image
//
//  Created by Mujahid on 09/11/21.
//

import Foundation
import UIKit

struct ImageArray {
    var name: UIImage?
}

struct ImageResponse: Decodable {
    var message: String?
    var status: String?
}
