//
//  ViewController.swift
//  For2048
//
//  Created by Zhaoyang Li on 10/23/20.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    let viewUsableWidth = UIScreen.main.bounds.width * 0.9
    var originalMatrix = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
    var matrix = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
    var flagMatrix = [
                        [false, false, false, false],
                        [false, false, false, false],
                        [false, false, false, false],
                        [false, false, false, false]
                                                    ] // ture means own-value
    let viewModel = ViewModel()
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBOutlet weak var mainCollectionView: UICollectionView! {
        didSet {
            mainCollectionView.delegate = self
            mainCollectionView.dataSource = self
            mainCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalMatrixSetting()
        originalUIsetting()
    }
    
    private func originalUIsetting() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHandler))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHandler))
        leftSwipe.direction = .left
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeHnadler))
        upSwipe.direction = .up
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeHandler))
        downSwipe.direction = .down
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    private func originalMatrixSetting() {
        let columeRandom = Int.random(in: 0...3)
        let rowRandom = Int.random(in: 0...3)
        matrix[columeRandom][rowRandom] = 2
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(flagController), userInfo: nil, repeats: true)
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        matrix = originalMatrix
        originalMatrixSetting()
        mainCollectionView.reloadData()
    }
    
    @objc func flagController() {
        for columeCounter in 0..<matrix.count {
            for rowCounter in 0..<matrix[columeCounter].count {
                if matrix[columeCounter][rowCounter] == 0 {
                    flagMatrix[columeCounter][rowCounter] = false
                } else {
                    flagMatrix[columeCounter][rowCounter] = true
                }
            }
        }
    }
    
    @objc private func upSwipeHnadler() {
        viewModel.upHandler(inputMatrix: matrix) { (newMatrix) in
            self.matrix = newMatrix
            self.addRandomCube()
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }

    @objc private func leftSwipeHandler() {
        viewModel.leftHandler(inputMatrix: matrix) { newMatrix in
            self.matrix = newMatrix
            self.addRandomCube()
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }

    @objc private func rightSwipeHandler() {
        viewModel.rightHandler(inputMatrix: matrix) { newMatrix in
            self.matrix = newMatrix
            self.addRandomCube()
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }

    @objc private func downSwipeHandler() {
        viewModel.downHandler(inputMatrix: matrix) { newMatrix in
            self.matrix = newMatrix
            self.addRandomCube()
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    private func addRandomCube() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            var counter = 0
            for row in self.flagMatrix {
                for element in row where element == true {
                    counter += 1
                }
            }
            if counter >= 16 {
                let alertController = UIAlertController(title: "You Failed", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "New Game", style: .default) { _ in
                    self.matrix = self.originalMatrix
                    self.originalMatrixSetting()
                    self.mainCollectionView.reloadData()
                }
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            var columeRandom = Int.random(in: 0...3)
            var rowRandom = Int.random(in: 0...3)
            while self.flagMatrix[columeRandom][rowRandom] == true {
                columeRandom = Int.random(in: 0...3)
                rowRandom = Int.random(in: 0...3)
            }
            self.matrix[columeRandom][rowRandom] = 2
            self.mainCollectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let digit = matrix[indexPath.row / 4][indexPath.row % 4]
        cell.configureCell(digit: digit)
        cell.layer.cornerRadius = 5
        switch digit {
        case 0:
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        case 2:
            cell.backgroundColor = .systemGreen
        case 4:
            cell.backgroundColor = .yellow
        case 8:
            cell.backgroundColor = .orange
        case 16:
            cell.backgroundColor = .red
        case 32:
            cell.backgroundColor = .brown
        case 64:
            cell.backgroundColor = .blue
        case 128:
            cell.backgroundColor = .gray
        case 256:
            cell.backgroundColor = .darkGray
        case 512:
            cell.backgroundColor = .green
        case 1024:
            cell.backgroundColor = .cyan
        case 2048:
            cell.backgroundColor = .purple
        default:
            cell.backgroundColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewUsableWidth / 4 - 2, height: viewUsableWidth / 4 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
