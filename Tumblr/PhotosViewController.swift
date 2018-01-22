//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Simona Virga on 1/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import AlamofireImage
  
class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

   
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoTableViewCell
       
        let post = posts[indexPath.row]

        if let photos = post["photos"] as? [[String: Any]]
        {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
           
            cell.picture.af_setImage(withURL: url!)            
        }
        return cell
    }
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self

        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            {
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
               
                // TODO: Reload the table view
                self.tableView.reloadData()
            }
        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[(indexPath.row)]
        let vc = segue.destination as! PhotoDetailsViewController
      //  vc.photoImageDetails = post
    }
  

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
