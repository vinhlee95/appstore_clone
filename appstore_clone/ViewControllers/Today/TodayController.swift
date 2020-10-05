//
//  TodayController.swift
//  appstore_clone
//
//  Created by Vinh Le on 9/13/20.
//  Copyright © 2020 Vinh Le. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UIGestureRecognizerDelegate {
    private var animatingCellFrame: CGRect!
    private var appFullScreenController: AppFullScreenController!
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var getGamesAPI = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/10/explicit.json"
    private var getFreeAppsAPI = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/10/explicit.json"
    private var items = [TodayItem]()
    private var isAppFullscreenShown = false
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .large
        loading.color = .gray
        loading.startAnimating()
        loading.hidesWhenStopped = true
        return loading
    }()
    
    private let overlayView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489068389, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayDailyAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        setupViews()
        fetchApps()
    }
    
    fileprivate func setupViews() {
        collectionView.addSubview(loadingIndicator)
        loadingIndicator.centerXY()
        view.addSubview(overlayView)
        overlayView.fillSuperview()
        overlayView.alpha = 0
    }
    
    fileprivate func fetchApps() {
        var gameGroup: AppFeed?
        var freeAppsGroup: AppFeed?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkService.shared.fetchAppsByUrl(urlString: getGamesAPI) { (appFeed, error) in
            dispatchGroup.leave()
            if error != nil {
                return
            }
            gameGroup = appFeed
        }
        
        dispatchGroup.enter()
        NetworkService.shared.fetchAppsByUrl(urlString: getFreeAppsAPI) { (appFeed, error) in
            dispatchGroup.leave()
            if error != nil {
                return
            }
            freeAppsGroup = appFeed
        }
        
        dispatchGroup.notify(queue: .main) {
            self.loadingIndicator.stopAnimating()
            self.items = [
                TodayItem.init(category: "HOLIDAYS", description: "Find out all you need to know on how to travel without packing everything!", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
                TodayItem.init(category: "Daily list", description: "All the tools and apps you need to intelligently organize your life the right way.", title: gameGroup?.title ?? "", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, apps: gameGroup?.results ?? []),
                TodayItem.init(category: "Daily  list", description: "All the tools and apps you need to intelligently organize your life the right way.", title: freeAppsGroup?.title ?? "", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .multiple, apps: freeAppsGroup?.results ?? []),
                TodayItem.init(category: "THE DAILY LIST", description: "All the tools and apps you need to intelligently organize your life the right way.", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), backgroundColor: .white, cellType: .single, apps: []),
            ]
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        if selectedItem.cellType == .multiple {
            self.presentDailyAppList(appList: selectedItem.apps)
            return
        }
        
        presentSingleAppFullscreen(indexPath: indexPath)
    }
        
    @objc func handleDismissAppFullscreen() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.appFullScreenController.tableView.contentOffset = .zero
            
            // Reset transform when dragging down app fullscreen view
            self.appFullScreenController.view.transform = .identity
            
            self.appFullscreenAnchor?.top?.constant = self.animatingCellFrame.origin.y
            self.appFullscreenAnchor?.leading?.constant = self.animatingCellFrame.origin.x
            self.appFullscreenAnchor?.width?.constant = self.animatingCellFrame.width
            self.appFullscreenAnchor?.height?.constant = self.animatingCellFrame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = false
            
            // Reset padding top for the header cell
            self.setupHeaderPaddingTop(paddingTop: 24, removingButton: true)
            
            self.overlayView.alpha = 0
            self.isAppFullscreenShown = false
        }, completion: { _ in
            self.appFullScreenController.tableView.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        })
    }
    
    fileprivate func setupHeaderPaddingTop(paddingTop: CGFloat, removingButton: Bool = false) {
        guard let todayHeaderCell = self.appFullScreenController.tableView.cellForRow(at: .init(row: 0, section: 0)) as? TodayFullscreenHeader else {return}
        
        todayHeaderCell.todayCell.topConstraint?.constant = paddingTop
        todayHeaderCell.todayCell.layoutIfNeeded()
        if removingButton {
            todayHeaderCell.closeButton.removeFromSuperview()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.cellType.rawValue, for: indexPath) as! BaseTodayCell
        cell.todayItem = cellData
        
        (cell as? TodayDailyAppCell)?.dailyAppListController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectAppList)))
        
        return cell
    }
    
    @objc fileprivate func handleSelectAppList(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        // Figure out which cell we are clicking to
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayDailyAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                self.presentDailyAppList(appList: self.items[indexPath.item].apps)
                return
            }
            
            superView = superView?.superview
        }
    }
    
    fileprivate func presentDailyAppList(appList: [AppFeedResult]) {
        let dailyAppListController = DailyAppListController(mode: .fullScreen)
        dailyAppListController.appList = appList
        let navigationController = BackEnabledNavigationController(rootViewController: dailyAppListController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: true, completion: nil)
    }
    
    fileprivate func setupAppFullscreenController(indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = selectedItem
        appFullScreenController.dismissHandler = {
            self.handleDismissAppFullscreen()
        }
        
        // Setup pan gesture
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDragAppFullscreen))
        gesture.delegate = self
        appFullScreenController.view.addGestureRecognizer(gesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    var appFullscreenBeginOffset: CGFloat = 0
    
    @objc fileprivate func handleDragAppFullscreen(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
        
        if gesture.state == .began {
            appFullscreenBeginOffset = appFullScreenController.tableView.contentOffset.y
        }
        
        let offset = translation.y - appFullscreenBeginOffset
        let scale = max(1 - offset/1000, 0.7)
        let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
        
        if translation.y < 0 || appFullScreenController.tableView.contentOffset.y > 0 {
            return
        }

        switch gesture.state {
        case .changed:
            if scale <= 0.7 && isAppFullscreenShown {
                handleDismissAppFullscreen()
                return
            }
            appFullScreenController.view.transform = transform
            
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
                self.appFullScreenController.view.transform = .init(scaleX: 1, y: 1)
            }, completion: nil)
            
        default:
            return
        }
    }
    
    
    var appFullscreenAnchor: AnchoredConstraints?
    
    fileprivate func setupInitialPosition(indexPath: IndexPath) {
        let appFullScreenView = appFullScreenController.view!
        view.addSubview(appFullScreenView)
        self.addChild(appFullScreenController)
        
        // Absolute coordinate of the cell
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        animatingCellFrame = startingFrame
        
        // Auto layout constraints
        appFullscreenAnchor = appFullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, paddingTop: startingFrame.origin.y, paddingLeft: startingFrame.origin.x, size: .init(width: startingFrame.width, height: startingFrame.height))
        
        view.layoutIfNeeded()
    }
    
    fileprivate func animateToFullscreen() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.appFullscreenAnchor?.top?.constant = 0
            self.appFullscreenAnchor?.leading?.constant = 0
            self.appFullscreenAnchor?.width?.constant = self.view.frame.width
            self.appFullscreenAnchor?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = true
            
            // Increase padding top for the today header cell
            self.setupHeaderPaddingTop(paddingTop: 60)
            
            // Setup overlay view
            self.overlayView.alpha = 1
            
            self.isAppFullscreenShown = true
        }, completion: nil)
    }
    
    fileprivate func presentSingleAppFullscreen(indexPath: IndexPath) {
        // Populate individual cell data
        setupAppFullscreenController(indexPath: indexPath)
        
        // Setup initial position for the app fullscreen view
        setupInitialPosition(indexPath: indexPath)
        
        // Animate the AppFullscreenController
        animateToFullscreen()
    }
    
    static let cellSize: CGFloat = 450
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 44, right: 0)
    }
}
