//
//  DetailsVC.swift
//  Food_Recipes
//
//  Created by MAC on 03/10/2023.
//
import Foundation
import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
    }
    @IBOutlet weak var myCollection: UICollectionView!
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
        if(favViewModel?.isRecipeExist(recipe: receipe?.id ?? 0)==true){
            favBtn.image = UIImage(named: "like-2")
        }else{
            favBtn.image  = UIImage(named: "imgLike")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        setPageHeader()
        favViewModel = FavoriteViewModel(coreData: RecipieCoreData.sharedInstance)
        
        myCollection.register(UINib(nibName: "DetailsCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCell")
        myCollection.register(UINib(nibName: "CollectionCellRecipe", bundle: nil), forCellWithReuseIdentifier: "CollectionCellRecipe")
       
        let layout = UICollectionViewCompositionalLayout{ index , environment in
            switch index {
            case 0 :
                return self.ingradiantsSection()
            case 1 :
                return self.ingradiantsSection()
            default:
                return self.similariesSection()
            }
        }
        myCollection.setCollectionViewLayout(layout, animated: true)
        
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
                self?.myCollection.reloadData()
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
        
    func ingradiantsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Dynamic group size based on the cell content
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.2) // Initial estimated height, you can adjust it as needed
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 0, trailing: 8)
        section.boundarySupplementaryItems = [self.supplementryHeaderItem()]
        section.supplementariesFollowContentInsets = false

        return section
       }
    func similariesSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing:8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [self.supplementryHeaderItem()]
        section.supplementariesFollowContentInsets = false
        return section
    }

    private func supplementryHeaderItem()-> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)),elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
    }
}

extension DetailsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader :
            let myHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            
            // Determine the section and set the header text accordingly
            print("Header 00000")
            switch indexPath.section {
            case 0:
                myHeader.headerLabel.text = "Ingredients"
            case 1:
                myHeader.headerLabel.text = "Instructions"
            default:
                myHeader.headerLabel.text = "Similarities"
            }
            
            return myHeader
        default: return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsVC
        details.modalPresentationStyle = .fullScreen
        details.receipe = similarites?[indexPath.row]
        present(details,animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return receipe?.sections?.count ?? 0
        }else if(section == 1){
            return receipe?.instructions?.count ?? 0
        }else{
            return similarites?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 2){
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCellRecipe", for: indexPath) as! CollectionCellRecipe
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
        }else if(indexPath.section == 1){
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
            cell.myText.text = receipe?.instructions?[indexPath.row].displayText
            cell.maxHeight = myCollection.bounds.height - 6
            return cell
        }else{
            let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
            cell.myText.text = receipe?.sections?[0].components?[indexPath.row].rawText
            cell.maxHeight = myCollection.bounds.height - 6
            return cell
        }
    }
    
}

