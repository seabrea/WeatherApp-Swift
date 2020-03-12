//
//  PersonalViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/8.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class PersonalViewController: UIViewController {
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width/1.3))
        return imageView
    }()
    
    lazy var avplayerView: UIView = {
        let playerView = UIView(frame: CGRect(x: 0, y: view.bounds.width/1.3, width: view.bounds.width, height: view.bounds.width * 9 / 16))
        playerView.backgroundColor = .black
        return playerView
    }()
    

    override func viewDidLoad() {

        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        
        view.addSubview(topImageView)
        view.addSubview(avplayerView)
        
        topImageView.sd_setImage(with: URL(string: DefineConst.TestImageUrl)!, completed: nil)
        
//        DispatchQueue.global().async {
//
//            var image:UIImage?
//            do {
//                let data = try Data(contentsOf: URL(string: DefineConst.TestImageUrl)!)
//                image = UIImage(data: data)
//            }
//            catch {
//                fatalError()
//            }
//
//            if (image != nil) {
//                DispatchQueue.main.async {
//                    self.topImageView.image = image
//                }
//            }
//        }
        
//        guard let mp4Url = URL(string: DefineConst.TestMap4Url) else {
//            fatalError()
//        }
//        let playerController = AVPlayer(url: mp4Url)
//        let playerLayer = AVPlayerLayer(player: playerController)
//        playerLayer.frame = avplayerView.bounds
//        avplayerView.layer.addSublayer(playerLayer)
//        playerController.play()
        
    }
}
