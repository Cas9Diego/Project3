//
//  ViewController.swift
//  Project1
//
//  Created by Diego Castro on 26/07/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]() //This variable is defined outside of the below class, because we want it to exist as long as the viewcontroller exists. çotherwise, it would be destroyed whemn viewDidLoad finishes

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default //Filemanager.default is a built-in system type that let's us work with a file system
        let path = Bundle.main.resourcePath! //This constant sets the resoure path of our apps bundle. A bundle is a directory containing our compiled program and all our assets, so this constant says "Tell me where I can find all the images that I added". The EXCLAMATION MARK is necessary because our main bundle may not have a resource path, because some app bundles dont have a resource path. However, iOS main bundles always have a resource path, so it is ok to do forced unwrapping
        let items = try! fm.contentsOfDirectory(atPath: path) // this variable is set to the content of the directory at a path, which path? the one we defined before. Basicaly, we say "USe the filemanager to read the documents at a certain path, the path we signaled".
        
        for item in items {
            if item.hasPrefix ("nssl") {
                pictures.append(item)
            }
        }
        print (pictures)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //This table has only one section (default) and pictures.count is the number of rows
        return pictures.count
    } //The override key means that this method is changing the behavious ir inherits from its parent class
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //The first parametert indicates that this method is called everytime a cell is created.
        //indexPath contains a number for sections and one for rows, since there is only one section here, that one is ignored.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) // The cell is created by dequeing and recycling cells from the table.
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell //Sets a text label to each cell.
        
    } //This method specifies what each row should look like
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true) //This pushes th Detail view controller into the screen of the user
            
        }
    }


}

