//
//  ImageVmNetworkManager.swift
//  Random Image
//
//  Created by Mujahid on 10/11/21.
//

import Foundation
import Alamofire

protocol ImageVmNetworkManagerProtocol {
    func getImage(completion: @escaping (_ data: ImageResponse?, _ error: Error?) -> Void)
    func downloadImage(url: String?,completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}

struct ImageVmNetworkManager: ImageVmNetworkManagerProtocol {
    func downloadImage(url: String?,completion: @escaping (Data?, Error?) -> Void) {
        guard let finalUrl = URL(string: url ?? "") else {return}
        AF.request(finalUrl, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                guard let imageData = responseData else {
                    debugPrint("error")
                    return
                }
                completion(imageData, nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func getImage(completion: @escaping (ImageResponse?, Error?) -> Void) {
        AF.request(CommonLiteral.END_POINT_URL, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                guard let data = responseData else {
                    debugPrint("error")
                    return
                }
                do {
                    let res = try? JSONDecoder().decode(ImageResponse.self, from: data)
                    if let r = res {
                        completion(r, nil)
                    } else {
                        debugPrint("error")
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

struct ImageVm2NetworkManager: ImageVmNetworkManagerProtocol {
    func downloadImage(url: String?,completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: url ?? "")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        })
        task.resume()
    }
    
    func getImage(completion: @escaping (ImageResponse?, Error?) -> Void) {
        let url = URL(string: CommonLiteral.END_POINT_URL)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let res = try? JSONDecoder().decode(ImageResponse.self, from: data)
                if let r = res {
                    completion(r, nil)
                } else {
                    debugPrint("error")
                }
            }
        })
        task.resume()
    }
    
}
