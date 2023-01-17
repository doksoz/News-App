//
//  WebVC.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 24.12.2022.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    
    var mNew: News?
    var mSave: Save?
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(mSave?.url == nil){
            let url = URL (string: mNew!.url)
            let request = URLRequest(url: url!)
            webView.load(request)
        }else{
            let url = URL (string: mSave!.url!)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
        
        // Do any additional setup after loading the view.
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
