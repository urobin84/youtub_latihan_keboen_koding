//
//  ViewController.swift
//  YoutubeMQR
//
//  Created by Pungs on 27/02/19.
//  Copyright © 2019 Pungs. All rights reserved.
//

import UIKit

// kelas controller home
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

//    var videos: [Video] = {
//        var mqrChannel = Channel()
//        mqrChannel.name = "MQRIsTheBestChannel"
//        mqrChannel.profileImageName = "profile-rbn"
//
//       var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "MQR - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "robin"
//        blankSpaceVideo.channel = mqrChannel
//        blankSpaceVideo.numberOfViews = 239843093
//
//        var RobinVideo = Video()
//        RobinVideo.title = "Robin - Blank Space Lorem opsum lorem opsum bla bla bla"
//        RobinVideo.thumbnailImageName = "WriteRobin"
//        RobinVideo.channel = mqrChannel
//        RobinVideo.numberOfViews = 123412341
//
//        return [blankSpaceVideo, RobinVideo]
//    }()
    
    var videos: [Video]?
    
    //func fatchVideos mengambil data dari internet dan memasukkan nilainya kedalam object video
    func fatchVideos(){
        //menetapkan url
        guard let url = URL(string: "https://contoh/list") else {return}
        //jenis session
        let session = URLSession.shared
        //pengambila data yang didapat dari url
        session.dataTask(with: url) { (data, response, error) in
            
            //jika merespon
            if response != nil {
//                print(response as Any)
            }
            
            //jika nilai data ada
            if let data = data {
                //akan melakukan pengulangan terhadap index data
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as AnyObject
//                    let jsonmessage = json["message"]
//                    let Jsonpesan:String = jsonmessage as! String
                    //pendefinisian dirinya (video) sama dengan class video yang ada di file video.swift
                    self.videos = [Video]()
                    //untuk nilai dictionary di dalam json array data yang bernilai string : mungkin object
                    for dictionary in json["data"] as! [[String: AnyObject]]{
                        //mendefinisikan video adalah func fideo
                        let video = Video()
                        //mendefinisikan title video samadengan nilai dictionary title yang didapat dari internet
                        video.title = dictionary["title"] as? String
                        //mendefinisikan gambar nya class video dengan nilai dictionary url gambar dari internet
                        video.thumbnailImageName = dictionary["url"] as? String
                        //update nilai video dari internet berdasarkan index
                        self.videos?.append(video)
                        //test tampilkan nilai dictionary url
//                        print(dictionary["url"])
                    }
                    // kembali menampilkan data terbaru dari collectionview
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                    
                }catch{
                    //apabila terjadi errror tampilkan pesan errornya
                    print(error)
                }
            }
            }.resume()
    }
    
    //function yang dipanggil setelah class homecontroller di panggil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Header
        
        //fungsi untuk mengambil data dari internet
        fatchVideos()
        
        //menetapkan judul yang ada di navbar halaman ini dengan title home
        navigationItem.title = "Home"
        //memunculkan object di navbar
        navigationController?.navigationBar.isTranslucent = false
        
        // menetapkan var title label sebagai label yang memiliki posisi x:0 y:0 lebar menyesuaikan view frame dikurang 32 dan tinggi setinggi view frame
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        //menetapkan text lebel bernilai Home
        titleLabel.text = "Home"
        //menetapkan warna tulisan title label dengan warna putih
        titleLabel.textColor = UIColor.white
        //menetapkan navigasi tilenya adalah titlelabel
        navigationItem.titleView = titleLabel
        
        //menetapkan warna latar dari collectionview dengan warna putih
        collectionView?.backgroundColor = UIColor.white
        
        //mendafratkan class VideoCell kedalam collectionView dan mengidentifikasikannya dengan nama cellID
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        //menentukan content memiliki jarak atas 50 px
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        //menentukan scroll indicator meiliki jarak 50 px dari frame atas
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        //memanggil function setup menu bar
        setupMenuBar()
        //memanggil function setupNavBarButtons
        setupNavBarButtons()
        
    }
    
    func setupNavBarButtons(){
        //menentukan gambar search dengan tampilan sesuai aslinya
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        //menentukan tombol search dengan gambar searchImage memanggil handleSearch saat di klik
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        //menentukan gambar dots mor nav dengan tampilan sesuai aslinya
        let moreNavImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        //menentukan tombol mornav dengan gambar moreNavImage memanggil handleMore saat di klik
        let moreButton = UIBarButtonItem(image: moreNavImage, style: .plain, target: self, action: #selector(handleMore))
        //meletakkan more button dan search button ke navbar sebelah kanan
        self.navigationItem.rightBarButtonItems = [moreButton,searchButton]
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore(){
        //Show menu
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting:Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    @objc func handleSearch(){
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //fungsi setup menu bar
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        //mendaftarkan menu bar ke view
        view.addSubview(menuBar)
        //menentukan menu bar horizontal(panjang) memiliki vektor 0
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        //menetukkan menu bar vertical(tinggi) memiliki vektor 50
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)

        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    //fungsiuntuk mendaftarkan jumlah item dalam collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //mengambil jumlah dari video yang ada
        return videos?.count ?? 0
       
    }
    //fungsi untuk menentukan isi tiap cell dari collection view
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //memasukkan nilai cellId dengan index kedlam variable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        //menentukkan cell video disi dengan item video dengan index yang ada
        cell.video = videos?[indexPath.item]
        //mengambalikkan nilai cell
        return cell
    }
    
    //menentukkan ukuran collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //menentukan nilai height
        let height = (view.frame.width - 16 - 16) * 9 / 16
        // mengembalikan nilai panjang sesuai frme dan tinggi
        return CGSize(width:(collectionView.frame.width), height: height + 16 + 88)
    }

    //menentukkan jarak antar cell collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
