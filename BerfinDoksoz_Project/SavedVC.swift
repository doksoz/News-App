//
//  SavedVC.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 21.12.2022.
//

import UIKit
import CoreData
import SCLAlertView

class SavedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mSaved = [Save]()

    var refresher: UIRefreshControl!
    
    @IBOutlet weak var savedTableView: UITableView!
    
    @objc func refresh(){
        fetchData().self
        self.savedTableView.reloadData()
        self.refresher.endRefreshing()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            leftSwipe.direction = .left
            rightSwipe.direction = .right
            self.view.addGestureRecognizer(leftSwipe)
            self.view.addGestureRecognizer(rightSwipe)
        
        
        
        refresher = UIRefreshControl()
        savedTableView.refreshControl = refresher

        refresher.addTarget(self, action: #selector(SavedVC.refresh), for: UIControl.Event.valueChanged)
        
        refresh()
        
        fetchData().self
        
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
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Save")
        
        let sortDescriptor1 = NSSortDescriptor(key: "source", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        do {
            let results = try context.fetch(fetchRequest)
            mSaved = results as! [Save]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func getIndexPathForSelectedRow() -> IndexPath? {
        var indexPath: IndexPath?
        
        if savedTableView.indexPathsForSelectedRows!.count > 0 {
            indexPath = savedTableView.indexPathsForSelectedRows![0] as IndexPath
        }
        
        return indexPath
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mSaved.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let new = mSaved[indexPath.section]
    
        cell.shareDelegate = self
        cell.index = indexPath
        
        var imageURL: URL? {
            guard let urlToImage = new.urlToImage else {
                return nil
            }
            return URL(string: urlToImage)
        }
        
        print("NEW DESCRIPTION", new.description)
        
        let data = try? Data(contentsOf: imageURL!)
        cell.cellTitle?.text = new.title
        cell.cellDesc?.text = new.descriptionCore
        cell.cellImage.image = UIImage(data: data!)
        cell.cellDate?.text = new.publishedDate
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

         let noteEntity = "Save" //Entity Name

         let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

         let save = mSaved[indexPath.row]

         if editingStyle == .delete {
            managedContext.delete(save)

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }

         }
        
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "logo")
        alertView.showInfo("Deleted ✅", subTitle: "Choosen saved item is deleted.", circleIconImage: alertViewIcon)
        
        fetchData().self
        savedTableView.reloadData()
    }
    
    func someMethod(cell: UITableViewCell){
        
    }
    
    func save() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                try context.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = getIndexPathForSelectedRow() {
            
            let new = mSaved[indexPath.section]
            
            let webVC = segue.destination as! WebVC
            
            webVC.mSave = new
        }
    }
    
    
    @IBAction func playStopMusic(_ sender: UIBarButtonItem) {
        playSound(sound: "scott-buckley-moonlight", type: "mp3")
    }
    
}

extension  SavedVC: ShareLink{
    func onClickShare(index: IndexPath) {
        let save = mSaved[index.section]
        
        var articleURL: URL {
            URL(string: save.url!)!
        }
        
        let shareSheetVC = UIActivityViewController(
            activityItems: [
                articleURL
            ],
            applicationActivities: nil)
        present(shareSheetVC, animated:true)
    }
}
