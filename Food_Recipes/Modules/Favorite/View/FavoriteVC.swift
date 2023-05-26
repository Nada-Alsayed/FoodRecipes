//
//  FavoriteVC.swift
//  Food_Recipes
//
//  Created by Mac on 26/05/2023.
//

import UIKit

class FavoriteVC: UIViewController {
    var favViewModel:FavoriteViewModel?
    @IBOutlet weak var favLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)
        var favArr:[Recipe] = favViewModel?.getSoredFavs() ?? []
        favLabel.text = favArr[0].recipeName
        //favLabel.text = "Eman"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
