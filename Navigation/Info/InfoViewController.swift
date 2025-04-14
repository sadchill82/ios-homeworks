//
//  InfoViewController.swift
//  Navigation
//

import UIKit

final class InfoViewController: UIViewController, UITableViewDataSource {
    
    private let toDoResultLabel = UILabel()
    private let planetResultLabel = UILabel()
    private let residentsTableView = UITableView()
    private var residents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Create Alert Button
        let alertButton = UIButton()
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.setTitle("Alert", for: .normal)
        alertButton.backgroundColor = .systemPink
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.layer.cornerRadius = 12
        alertButton.addTarget(self, action: #selector(tapAlertButton), for: .touchUpInside)
        
        // Create Fetch Button
        let fetchButton = UIButton()
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.setTitle("Fetch", for: .normal)
        fetchButton.backgroundColor = .systemBlue
        fetchButton.setTitleColor(.white, for: .normal)
        fetchButton.layer.cornerRadius = 12
        fetchButton.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        
        // Setup YoDo Result Label
        toDoResultLabel.translatesAutoresizingMaskIntoConstraints = false
        toDoResultLabel.textAlignment = .center
        toDoResultLabel.numberOfLines = 0
        toDoResultLabel.text = "To Do Result will be shown here"
        
        // Setup Planet Result Label
        planetResultLabel.translatesAutoresizingMaskIntoConstraints = false
        planetResultLabel.textAlignment = .center
        planetResultLabel.numberOfLines = 0
        planetResultLabel.text = "Planet Result will be shown here"
        
        // Setup Residents Table View
        residentsTableView.translatesAutoresizingMaskIntoConstraints = false
        residentsTableView.dataSource = self
        residentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Add Subviews
        view.addSubview(alertButton)
        view.addSubview(fetchButton)
        view.addSubview(toDoResultLabel)
        view.addSubview(planetResultLabel)
        view.addSubview(residentsTableView)
        
        // Setup Constraints
        NSLayoutConstraint.activate([
            // Alert Button
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.widthAnchor.constraint(equalToConstant: 100),
            
            // Fetch Button
            fetchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fetchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fetchButton.heightAnchor.constraint(equalToConstant: 50),
            fetchButton.widthAnchor.constraint(equalToConstant: 100),
            
            // Result Label
            toDoResultLabel.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 20),
            toDoResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toDoResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Planet Result Label
            planetResultLabel.topAnchor.constraint(equalTo: toDoResultLabel.bottomAnchor, constant: 20),
            planetResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planetResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
            // Residents Table View
            residentsTableView.topAnchor.constraint(equalTo: planetResultLabel.bottomAnchor, constant: 20),
            residentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            residentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            residentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func tapAlertButton() {
        let alert = UIAlertController(title: "Attention",
                                      message: "How are you feeling?",
                                      preferredStyle: .alert)
        let fine = UIAlertAction(title: "Fine", style: .default) { _ in
            print("Fine")
        }
        alert.addAction(fine)
        
        let so = UIAlertAction(title: "So-so", style: .destructive) { _ in
            print("So-so")
        }
        alert.addAction(so)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func fetchData() {
        fetchTodo()
        fetchPlanet()
        fetchResidents()
    }
    
    // MARK: - Networking
    private func fetchTodo() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let title = json["title"] as? String {
                    DispatchQueue.main.async {
                        self.toDoResultLabel.text = "Todo Title: \(title)"
                    }
                }
            } catch {
                print("JSONSerialization error: \(error)")
            }
        }.resume()
    }
    
    private func fetchPlanet() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let planet = try JSONDecoder().decode(Planet.self, from: data)
                DispatchQueue.main.async {
                    self.planetResultLabel.text = "Planet Orbital Period: \(planet.orbitalPeriod)"
                }
            } catch {
                print("JSONDecoder error: \(error)")
            }
        }.resume()
    }
    
    private func fetchResidents() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let planet = try JSONDecoder().decode(PlanetWithResidents.self, from: data)
                self.fetchResidentNames(from: planet.residents)
            } catch {
                print("JSONDecoder error: \(error)")
            }
        }.resume()
    }
    
    private func fetchResidentNames(from urls: [String]) {
        let group = DispatchGroup()
        var fetchedResidents: [String] = []
        
        for urlString in urls {
            guard let url = URL(string: urlString) else { continue }
            group.enter()
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else { return }
                do {
                    let resident = try JSONDecoder().decode(Resident.self, from: data)
                    fetchedResidents.append(resident.name)
                } catch {
                    print("JSONDecoder error: \(error)")
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            self.residents = fetchedResidents
            self.residentsTableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residents[indexPath.row]
        return cell
    }
}
