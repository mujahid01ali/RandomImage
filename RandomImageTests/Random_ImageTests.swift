//
//  Random_ImageTests.swift
//  Random ImageTests
//
//  Created by Mujahid on 10/11/21.
//

import XCTest
import UIKit
@testable import RandomImage

class Random_ImageTests: XCTestCase {
    
    func test_image_url_found() {
        let vc = vc()
        let expected = expectation(description: "Download")
        vc.vm?.networkManager?.getImage(completion: { response, error in
            if error == nil {
                vc.vm?.networkManager?.downloadImage(url: response?.message, completion: { data, error in
                    if error == nil {
                        expected.fulfill()
                    } else {
                        XCTFail()
                    }
                })
            }else {
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(vc.ivImage.image)
    }
    
    func test_btn_prev_hidden() {
        let vc = vc()
        let expected = expectation(description: "Download")
        vc.vm?.networkManager?.getImage(completion: { response, error in
            if error == nil {
                vc.vm?.networkManager?.downloadImage(url: response?.message, completion: { data, error in
                    if error == nil {
                        expected.fulfill()
                    } else {
                        XCTFail()
                    }
                })
            }else {
                XCTFail()
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertTrue(vc.btnPrev.isHidden)
    }
}

extension Random_ImageTests {
    func vc() -> ViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let viewModel = ImageVm(networkManager: ImageVmNetworkManager())
        vc.setup(viewModel: viewModel)
        _ = vc.view
        return vc
    }
}
