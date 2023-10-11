//
//  VideoVC.swift
//  Food_Recipes
//
//  Created by MAC on 05/10/2023.
//

import UIKit
import AVKit
import AVFoundation

class VideoVC: UIViewController {

    @IBOutlet weak var thumpnail: UIImageView!
    @IBOutlet weak var videoBtn: UIImageView!
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    var videoRecipe : Reciepe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = videoRecipe?.originalVideoURL else { return }
        thumpnail.kf.setImage(with: URL(string:  videoRecipe?.thumbnailURL ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf-9vhp7--gDxiejt8MrzvQWG-yuM7ZqN6-51mVKFjtqUQ7ZwNUKjajpygTsqcsbbKmGg&usqp=CAU"))
       
        let playTapGesture = UITapGestureRecognizer(target: self, action: #selector(playTapped(_:)))
        videoBtn.isUserInteractionEnabled = true
        videoBtn.addGestureRecognizer(playTapGesture)
        
//    createThumbnailOfVideoFromRemoteUrl(url: url) { [weak self] thumbnail in
//        if let thumbnail = thumbnail {
//            self?.thumpnail.image = thumbnail
//
//        } else {
//            print("OOOPs")
//        }
//    }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    @objc func playTapped(_ sender : UITapGestureRecognizer ){
        self.palyVideo()
    }
    func palyVideo(){
        guard let videoUrl = videoRecipe?.originalVideoURL else { return }
        guard let videoURL = URL(string: videoUrl) else {return}
        playerView = AVPlayer(url: videoURL as URL)
        playerViewController.player = playerView
        
        //present
        self.present(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
    }
//    func createThumbnailOfVideoFromRemoteUrl(url: String, completion: @escaping (UIImage?) -> Void) {
//        // Create a background queue for asynchronous processing
//        DispatchQueue.global(qos: .background).async {
//            guard let videoURL = URL(string: url) else {
//                // Handle invalid URL here
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            let asset = AVAsset(url: videoURL)
//            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//            assetImgGenerate.appliesPreferredTrackTransform = true
//            let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
//
//            do {
//                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//                let thumbnail = UIImage(cgImage: img)
//
//                // Return the thumbnail on the main queue
//                DispatchQueue.main.async {
//                    completion(thumbnail)
//                }
//            } catch {
//                print(error)
//                // Return nil and handle the error on the main queue
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//        }
//    }

}
