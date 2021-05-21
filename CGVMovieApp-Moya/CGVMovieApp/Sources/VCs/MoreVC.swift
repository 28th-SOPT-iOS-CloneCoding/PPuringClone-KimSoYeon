//
//  MoreVCs.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import UIKit
import Moya
import SnapKit

class MoreVC: UIViewController {
    private let authProvider = MoyaProvider<MovieServices>()
    private var movieModel: MovieModel?
    private var movieData: [MovieResponse] = []
    
    private lazy var bookingButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        button.setGradient(color1: UIColor(red: 232/255, green: 99/255, blue: 109/255, alpha: 0.85), color2: UIColor(red: 218/255, green: 113/255, blue: 53/255, alpha: 0.85))
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(presentNowBookingVC), for: .touchUpInside)
        return button
    }()
    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor  = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.setImage(UIImage(named: "up-arrow-fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpTop), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterHeaderView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.systemGray6
        view.addSubview(popularitySortButton)
        view.addSubview(voteSortButton)
        view.addSubview(nowPlayingMovieButton)
        
        popularitySortButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        voteSortButton.snp.makeConstraints { make in
            make.leading.equalTo(popularitySortButton.snp.trailing).inset(-10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        nowPlayingMovieButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        return view
    }()
    
    private let popularitySortButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("• 인기순", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "", size: 13)
        return btn
    }()
    private let voteSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("• 투표율순", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "", size: 13)
        return button
    }()
    private let nowPlayingMovieButton: UIButton = {
        let button = UIButton()
        button.setTitle("✓ 현재상영작보기", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "", size: 13)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListTVC.self, forCellReuseIdentifier: MovieListTVC.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPopularMovie(page: 1)
        setConstraints()
        setNavigationBar()
        setScrollButtons()
    }
    
}

// MARK: - UI
extension MoreVC {
    func setConstraints() {
        view.addSubview(tableView)
        view.addSubview(bookingButton)
        view.addSubview(topButton)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(0)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(60)
            make.trailing.equalToSuperview().inset(-30)
            make.bottom.equalToSuperview().inset(30)
        }

        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(-100)
        }
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = "영화"
        
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(presentListVC(_:)))
        navigationItem.rightBarButtonItem = listButton
    }
    
    func setScrollButtons() {
        let smallTitleLabel = UILabel()
        let largeTitleLabel = UILabel()
        let imageView = UIImageView()
        
        bookingButton.addSubview(smallTitleLabel)
        bookingButton.addSubview(largeTitleLabel)
        bookingButton.addSubview(imageView)
        
        smallTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookingButton.snp.top).offset(13)
            make.leading.equalTo(bookingButton.snp.leading).offset(25)
        }
        largeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(smallTitleLabel.snp.bottom).offset(1)
            make.leading.equalTo(smallTitleLabel.snp.leading)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(bookingButton.snp.centerY)
            make.leading.equalTo(largeTitleLabel.snp.trailing).offset(5)
            make.height.equalTo(24)
            make.width.equalTo(35)
        }
        
        smallTitleLabel.text = "빠르고 쉽게"
        smallTitleLabel.font = .boldSystemFont(ofSize: 10)
        smallTitleLabel.textColor = .white
        
        largeTitleLabel.text = "지금예매"
        largeTitleLabel.font = .boldSystemFont(ofSize: 16)
        largeTitleLabel.textColor = .white
        
        imageView.image = UIImage.init(named: "ticket")
        imageView.tintColor = .white
    }
}

// MARK: - Action
extension MoreVC {
    @objc func presentNowBookingVC() {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "NowBookingVC") as? NowBookingVC else {
            return
        }
        
        dvc.modalTransitionStyle = .coverVertical
        dvc.modalPresentationStyle = .overCurrentContext
        present(dvc, animated: true, completion: nil)
    }
    
    @objc
    func touchUpTop() {
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
    @objc func presentListVC(_ sender: UIBarButtonItem) {
            print("list")
    }
}

// MARK: - TableView Delegate
extension MoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        filterHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topButton.isHidden = false
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
            bookingButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(45 + self.topButton.bounds.height)
            }
            
        } else {
            topButton.isHidden = true
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }
            bookingButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
        }
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - TableView DataSource
extension MoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTVC.identifier) as? MovieListTVC else { return UITableViewCell() }
        let movie = movieData[indexPath.row]
        cell.setValue(title: movie.title, poster: movie.posterPath!, release: movie.releaseDate, isAdult: movie.adult, popularity: movie.popularity, voteCount: movie.voteCount, voteAvg: movie.voteAverage)
        cell.selectionStyle = .none
        return cell
    }
}

extension MoreVC {
    private func getPopularMovie(page: Int) {
        
        let param: MovieRequest = MovieRequest.init(GeneralAPI.apiKey, "ko", page)
        print(param)
        
        authProvider.request(.popular(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.movieModel = try result.map(MovieModel.self)
                    self.movieData.append(contentsOf: self.movieModel?.results ?? [])
                    self.movieData = self.movieData.sorted(by: {$0.voteAverage > $1.voteAverage})
                    print("Get Popular Movie Data")
                    self.tableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}


extension UIView {
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}


