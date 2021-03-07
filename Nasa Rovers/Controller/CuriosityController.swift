//
//  ViewController.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class CuriosityController: UIViewController {
    
    var jsonDownloader: NasaAPIDownload {
        return NasaAPIDownload(rover: .Curiosity)
    }
    
    var nasaList: [NasaAPIList]? {
        didSet {
            filteredNasaList = nasaList
        }
    }
    
    var isFiltered = false {
        didSet {
            filteredNasaList = nasaList
        }
    }
    
    var filterKey = ""
    
    var filteredNasaList: [NasaAPIList]? {
        didSet {
            guard let nasaList = nasaList else { return }
            
            if isFiltered {
                filteredNasaList = nasaList.filter { $0.cameraName == filterKey }
            }
            collectionView.reloadData()
        }
    }
    
    var numberOfPage = 1
    var isPaginating = false
    
    let extraView = UIView()
    let topBar = CustomTopBar()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var customSpinnerCell: SpinnerCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getJsonData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        numberOfPage = 1
    }
    
    fileprivate func setLayout() {
        
        navigationController?.navigationBar.isHidden = true
        extraView.backgroundColor = .black
        setCollectionView()
        
        [extraView,topBar,collectionView].forEach { view.addSubview($0) }
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = topBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/17))
        _ = collectionView.anchor(top: topBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        topBar.filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func setCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.IDENTIFIER)
        collectionView.register(SpinnerCell.self, forCellWithReuseIdentifier: SpinnerCell.IDENTIFIER)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func getJsonData() {
        
        jsonDownloader.getData(inPage: numberOfPage) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            if let jsonData = data {
                self.nasaList = jsonData.compactMap(NasaAPIList.init)
            } else {
                print("Error Json Data")
            }
        }
    }
    
    fileprivate func loadMorePhotos() {
        
        if self.isPaginating {
            return
        } else {
            isPaginating = true
        }
        
        customSpinnerCell!.startSpinner()
        numberOfPage += 1
        
        jsonDownloader.getData(inPage: numberOfPage) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            self.isPaginating = false
            
            if let jsonData = data {
                
                if jsonData.count == 0 {
                    self.customSpinnerCell?.stopSpinner(showMessage: true)
                    return
                }
                
                var newList = jsonData.compactMap(NasaAPIList.init)
                
                if self.isFiltered {
                    if newList.filter({ $0.cameraName == self.filterKey }).count > 0 {
                        newList = newList.filter { $0.cameraName == self.filterKey }
                    } else {
                        self.customSpinnerCell?.stopSpinner(showMessage: true)
                        return
                    }
                }
                self.customSpinnerCell?.stopSpinner(showMessage: false)
                self.nasaList?.append(contentsOf: newList)
                
            } else {
                print("Error Json Data")
            }
        }
    }
    
    @objc fileprivate func imagePressed(gesture: UITapGestureRecognizer) {
        
        guard let gestureView = gesture.view, let data = filteredNasaList?[gestureView.tag] else { return }
        let popUp = PopUp()
        
        if let img = (gestureView as? UIImageView)?.image {
            popUp.setData(data: data, image: img)
            view.addSubview(popUp)
            popUp.positionInCenterSuperView(size: .init(width: view.frame.width/1.2, height: view.frame.height/1.8), centerX: view.centerXAnchor, centerY: view.centerYAnchor)
            
            view.animateIn(popUp)
        }
        
    }
    
    @objc fileprivate func filterButtonPressed() {
        
        let alertController = UIAlertController(title: "Filter", message: "Select a camera for filtering photos", preferredStyle: .alert)
        let alertTitle = ["ALL","FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM","PANCAM","MINITES"]
        for i in 0..<alertTitle.count {
            let alertAction = UIAlertAction(title: alertTitle[i], style: .default) { (action) in
                
                if action.title! == "ALL" {
                    self.isFiltered = false
                } else {
                    self.filterKey = action.title!
                    self.isFiltered = true
                }
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension CuriosityController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.filteredNasaList?.count ?? 0 > 0) ? (self.filteredNasaList?.count ?? 0) + 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row != filteredNasaList?.count {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.IDENTIFIER, for: indexPath) as? CustomCell else { return UICollectionViewCell() }
            
            guard let nasaData = filteredNasaList?[indexPath.row] else { return UICollectionViewCell() }
            cell.setImage(url: nasaData.imgSrc)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed(gesture:)))
            cell.imgSrc.tag = indexPath.row
            cell.imgSrc.addGestureRecognizer(gesture)
            
            return cell
            
        } else {
            
            guard let spinnerCell = collectionView.dequeueReusableCell(withReuseIdentifier: SpinnerCell.IDENTIFIER, for: indexPath) as? SpinnerCell else { return UICollectionViewCell() }
            
            customSpinnerCell = spinnerCell
            customSpinnerCell?.stopSpinner(showMessage: false)
            
            return customSpinnerCell!
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > collectionView.contentSize.height + 100 - scrollView.frame.height {
            loadMorePhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == filteredNasaList?.count {
            return CGSize(width: view.frame.width, height: view.frame.height/12)
        }
        return CGSize(width: view.frame.width, height: view.frame.height/2)
    }
    
}


