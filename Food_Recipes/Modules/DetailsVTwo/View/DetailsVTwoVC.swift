//
//  DetailsVTwoVC.swift
//  Food_Recipes
//
//  Created by MAC on 11/10/2023.
//

import UIKit

class DetailsVTwoVC: UIViewController {

    @IBOutlet weak var tableIngrediants: UITableView!
    @IBOutlet weak var tableInstructions: UITableView!
    @IBOutlet weak var collectionSimilar: UICollectionView!
   
    
    @IBOutlet weak var heightInstructions: NSLayoutConstraint!
    @IBOutlet weak var heightIngrediants: NSLayoutConstraint!
    
    
    @IBOutlet weak var backgImg: UIImageView!
    @IBOutlet weak var videoBtn: UIImageView!
    @IBOutlet weak var favBtn: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var backImg: UIImageView!
 
    var favViewModel:FavoriteViewModel?
    var receipe : Reciepe?
    var recipeID : Int?
    var similarites :[Reciepe]?
    var viewModel = DetailsViewModel(apiFetchHandler: NetworkerService())
    var recipeEntity = RecipeEntity()
    var arrayOfRecipes :[Reciepe]?
    var homeViewModel = HomeViewModel(apiFetchHandler: NetworkerService())
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableIngrediants.addObserver(self, forKeyPath: "ingrediantsContentSize",options: .new , context: nil)
        
        self.tableInstructions.addObserver(self, forKeyPath: "instructionsContentSize",options: .new , context: nil)
        
        if(favViewModel?.isRecipeExist(recipe: receipe?.id ?? 0)==true){
            favBtn.image = UIImage(named: "like-2")
        }else{
            favBtn.image  = UIImage(named: "imgLike")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tableIngrediants.removeObserver(self, forKeyPath: "ingrediantsContentSize")
        self.tableInstructions.removeObserver(self, forKeyPath: "instructionsContentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "ingrediantsContentSize"
        {
            if let newvalue = change?[.newKey]{
                let newsize = newvalue as! CGSize
                self.heightIngrediants.constant = newsize.height
            }
        }
        if keyPath == "instructionsContentSize"{
            if let newvalue = change?[.newKey]{
                let newsize = newvalue as! CGSize
                self.heightInstructions.constant = newsize.height
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSimilar.delegate = self
        collectionSimilar.dataSource = self
        
        tableIngrediants.delegate = self
        tableIngrediants.dataSource = self
        
        tableInstructions.delegate = self
        tableInstructions.dataSource = self
        
        setPageHeader()
        
        favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)
        
        //register cells
        collectionSimilar.register(UINib(nibName: "CollectionCellRecipe", bundle: nil), forCellWithReuseIdentifier: "CollectionCellRecipe")

       
        tableIngrediants.register(UINib(nibName: "DetailsTableCell", bundle: nil), forCellReuseIdentifier: "DetailsTableCell")
        tableInstructions.register(UINib(nibName: "DetailsTableCell", bundle: nil), forCellReuseIdentifier: "DetailsTableCell")
       
       // let customLayout = CustomCollectionViewLayout()
    //    collectionSimilar.collectionViewLayout = customLayout

        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped(_:)))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tapGesture)

        let favTapGesture = UITapGestureRecognizer(target: self, action: #selector(loveTapped(_:)))
        favBtn.isUserInteractionEnabled = true
        favBtn.addGestureRecognizer(favTapGesture)
        
        let videoTapGesture = UITapGestureRecognizer(target: self, action: #selector(videoTapped(_:)))
        videoBtn.isUserInteractionEnabled = true
        videoBtn.addGestureRecognizer(videoTapGesture)
       
        guard let id = receipe?.id else {
            return
        }
        let mySimilarURL :String = "https://tasty.p.rapidapi.com/recipes/list-similarities?recipe_id=\(id)"
        viewModel.bindResultToView = { [weak self]  in
            DispatchQueue.main.async {
                self?.similarites = self?.viewModel.res.results ?? []
                self?.collectionSimilar.reloadData()
            }
        }
        viewModel.getData(url:mySimilarURL)
    }
    @objc func backTapped(_ sender : UITapGestureRecognizer ) {
        dismiss(animated: true)
    }
    @objc func videoTapped(_ sender : UITapGestureRecognizer ){
        let video = self.storyboard?.instantiateViewController(withIdentifier: "myVideoVC") as! VideoVC
        video.modalPresentationStyle = .fullScreen
        video.videoRecipe = receipe
        present(video,animated: true)
    }
    
    func setPageHeader(){
        backgImg.kf.setImage(with:URL(string: receipe?.thumbnailURL ?? ""))
        mealNameLabel.text = receipe?.name ?? ""
        servingsLabel.text = receipe?.yields ?? "Servings:0"
        info.text = receipe?.show?.name ?? ""
    }
    
    @objc func loveTapped(_ sender : UITapGestureRecognizer ) {
        let recipeEntity = RecipeEntity(criditName: receipe?.credits?[0].name ,recipeImg: receipe?.thumbnailURL,recipeName: receipe?.name,recipeUrl: receipe?.videoURL,showName: receipe?.show?.name,yeild: receipe?.yields,id: receipe?.id)
        if(favViewModel?.isRecipeExist(recipe: receipe?.id ?? 0)==true){

            let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.favViewModel?.deleteFavRecipe(recipe: recipeEntity)
                self.favBtn.image  = UIImage(named: "imgLike")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               present(alert, animated: true, completion: nil)
                    
        }else{
            favViewModel?.insertFavRecipe(recipe:recipeEntity)
            favBtn.image = UIImage(named: "like-2")
        }
    }
}
extension DetailsVTwoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarites?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSimilar.dequeueReusableCell(withReuseIdentifier: "CollectionCellRecipe", for: indexPath) as! CollectionCellRecipe
        cell.myImgBG.layer.cornerRadius = 10
        cell.myImgBG?.kf.setImage(with:URL(string: similarites?[indexPath.row].thumbnailURL ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        if(favViewModel?.isRecipeExist(recipe: similarites?[indexPath.row].id ?? 0) == true){
            cell.imgLike.image = UIImage(named: "like-2")
        }else{
            cell.imgLike.image = UIImage(named: "imgLike")}
        cell.labelRecipeName.text = similarites?[indexPath.row].name
        cell.labelChefName.text = "\(similarites?[indexPath.row].credits?[0].name ?? "")"
        cell.labelPike.text = similarites?[indexPath.row].show?.name
        cell.labelServings.text = similarites?[indexPath.row].yields ?? "Servings:0"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "details2") as! DetailsVTwoVC
        details.modalPresentationStyle = .fullScreen
        details.receipe = similarites?[indexPath.row]
        present(details,animated: true)
    }
    
}

extension DetailsVTwoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return receipe?.sections?.count ?? 0
        }else{
            return receipe?.instructions?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1{
            let cell = tableInstructions.dequeueReusableCell(withIdentifier: "DetailsTableCell", for: indexPath) as! DetailsTableCell
            cell.myLabel.text = receipe?.instructions?[indexPath.row].displayText
            return cell
        }else if tableView.tag == 0{
            let cell = tableIngrediants.dequeueReusableCell(withIdentifier: "DetailsTableCell", for: indexPath) as! DetailsTableCell
            if receipe?.sections?.count != 0{
                cell.myLabel.text = receipe?.sections?[0].components?[indexPath.row].rawText
            }else{
                cell.myLabel.text = "No ingrediants available now"
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1{
            return UITableView.automaticDimension
        }else if tableView.tag == 0{
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1{
            return UITableView.automaticDimension
        }else if tableView.tag == 0{
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension
        }
    }
}
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60 // Adjust the value to set the desired height
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let spacingView = UIView()
//        spacingView.backgroundColor = .clear
//        return spacingView
//    }

//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10.0 // Adjust this value to control the spacing between cells
//    }

//class CustomCollectionViewLayout: UICollectionViewFlowLayout {
//    override var itemSize: CGSize {
//        get {
//            let collectionViewWidth = collectionView?.bounds.width ?? 0
//            let cellWidth = 0.7 * collectionViewWidth
//            return CGSize(width: cellWidth, height: 128)
//        }
//        set {
//            super.itemSize = newValue
//        }
//    }
//}

