import Foundation
@testable import Food_Recipes
class FakeNetwork {
    var returnError : Bool
    let fakeData : [String:Any] = [
        "video_url": "",
        "thumbnail_url": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
        "numServings": "5",
        "yields": "Italy",
        "show": "",
        "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
    ]
    
    init(returnError: Bool) {
        self.returnError = returnError
    }
    
    enum ResponseWithError : Error {
        case responseError
    }
}

extension FakeNetwork {
    func loadData(urls:String, handler:@escaping ([String:Any]?, Error?)->Void){
        if returnError == true{
            handler(nil,ResponseWithError.responseError)
        }else{
            handler(fakeData,nil)
        }
    }
}
