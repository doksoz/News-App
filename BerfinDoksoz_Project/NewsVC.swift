//
//  ViewController.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 21.12.2022.
//

import UIKit
import CoreData


class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mDataSource = DataSource()
    var isSaved: Bool = false
    var mSaved = [Save]()
    var category = ""
    
    @IBOutlet weak var playBtn: UIBarButtonItem!
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            leftSwipe.direction = .left
            rightSwipe.direction = .right
            self.view.addGestureRecognizer(leftSwipe)
            self.view.addGestureRecognizer(rightSwipe)
        
        playSound(sound: "scott-buckley-moonlight", type: "mp3")
        
        mDataSource.populate(category: category)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("left")
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            print("right")
            self.tabBarController!.selectedIndex -= 1
        }
    }
    
    //share link
    private func shareLink() {
        let shareSheetVC = UIActivityViewController(activityItems: [], applicationActivities: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mDataSource.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let news: [News] = mDataSource.itemsInCategory(index: indexPath.section)
        let new = news[indexPath.row]
        
        cell.cellDelegate = self
        cell.shareDelegate = self
        cell.index = indexPath
        
        let data = try? Data(contentsOf: new.imageURL!)
        cell.cellTitle?.text = new.title
        cell.cellDesc?.text = new.description
        cell.cellImage.image = UIImage(data: data!)
        cell.cellDate?.text = new.captionText
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = getIndexPathForSelectedRow() {
            
            let new = mDataSource.itemsInCategory(index: indexPath.section)[indexPath.row]
            
            let webVC = segue.destination as! WebVC
            
            webVC.mNew = new
        }
    }
    
    func getIndexPathForSelectedRow() -> IndexPath? {
        var indexPath: IndexPath?
        
        if mTableView.indexPathsForSelectedRows!.count > 0 {
            indexPath = mTableView.indexPathsForSelectedRows![0] as IndexPath
        }
        
        return indexPath
    }
    
    
    @IBAction func playStopMusic(_ sender: UIBarButtonItem) {
        playSound(sound: "scott-buckley-moonlight", type: "mp3")
    }
    
    func saveNewItem(_ source : String, title : String, url: String, publishedDate: String, author: String, descriptionCore: String, urlToImage: String, isSaved: Bool, index: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        if(mSaved.isEmpty){
            let newSavedItem = Save.createInManagedObjectContext(context, source: source, title: title, url: url, publishedDate: publishedDate, author: author, descriptionCore: descriptionCore, urlToImage: urlToImage, isSaved: isSaved)
            mSaved.append(newSavedItem)
        }else{
            if((mSaved.first{$0.title == title}) != nil){
                print("no changes")
            }else{
                let newSavedItem = Save.createInManagedObjectContext(context, source: source, title: title, url: url, publishedDate: publishedDate, author: author, descriptionCore: descriptionCore, urlToImage: urlToImage, isSaved: isSaved)
                    mSaved.append(newSavedItem)
            }
        }
        
        save()
    }
        
    func save() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                try context.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
    }
}

extension NewsVC: TableViewClick{
    func onClickButton(index: IndexPath){
        let new = mDataSource.itemsInCategory(index: index.section)[index.row]
        
        saveNewItem(new.source, title: new.title, url: new.url, publishedDate: new.captionText, author: new.author!, descriptionCore: new.description!, urlToImage: new.urlToImage!, isSaved: new.isSaved!, index: index)
    }
}

extension NewsVC: ShareLink{
    func onClickShare(index: IndexPath) {
        let new = mDataSource.itemsInCategory(index: index.section)[index.row]
        
        let shareSheetVC = UIActivityViewController(
            activityItems: [
            new.articleURL
            ],
            applicationActivities: nil)
        present(shareSheetVC, animated:true)
    }
}
