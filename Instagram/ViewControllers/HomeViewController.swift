//
//  HomeViewController.swift
//  Instagram
//
//  Created by MacBookPro9 on 11/21/18.
//  Copyright © 2018 MacBookPro9. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    @IBAction func onChooseImg(_ sender: Any) {
        performSegue(withIdentifier: "PickSegue", sender: self)

    }
    
    @IBAction func onLogout(_ sender: Any) {
        Logout()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    var refreshControl: UIRefreshControl!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        
        if let imageFile : PFFile = post.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else{
                    cell.photoImgView?.image = UIImage(data: data!)
                
                }
            }
        }
        
          cell.captionLabel.text = post["caption"] as? String
          cell.usernameLabel.text = post.author.username
       return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 300
        tableView.estimatedRowHeight = 350
        self.PostInfo()
        refreshEvery()
      
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func PostInfo() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.posts = objects! as! [Post]
                self.tableView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        }
    }
    
    func Logout(){
        let actionSheet = UIAlertController(title: "Closing Session", message: "Are you sure you want to Logout?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Disconnect", style: .default, handler: {(UIAlertAction) in
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func refreshEvery() {
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(HomeViewController.PostInfo), userInfo: nil, repeats: true)
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        PostInfo()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
