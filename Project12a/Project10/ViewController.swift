//
//  ViewController.swift
//  Project10
//
//  Created by Todor Dimitrov on 10.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople)as? [Person] {
                people = decodedPeople
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { fatalError("Unable to dequeue PersonCell.") }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename/Delete person", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { action in self.rename(action:action, person: person)
            
        }))
        ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            self.deletePerson(action: action, person: person,indexPath: indexPath)
        }))
             present(ac, animated: true)
        }
    
    @objc func rename(action: UIAlertAction, person: Person) {
        let ac = UIAlertController(title: "Enter a new name", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
         
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.save()
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    
    }
    
    @objc func deletePerson(action: UIAlertAction, person: Person,indexPath: IndexPath) {
        
        people.remove(at: indexPath.item)
        self.collectionView.deleteItems(at: [indexPath])
        collectionView.reloadData()
        
        let ac = UIAlertController(title: "Successfully deleted", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
    }


