//
//  ChatViewModel.swift
//  Elena
//
//  Created by Cain on 2018/3/22.
//  Copyright © 2018年 Cain. All rights reserved.
//

import UIKit

enum Question:Int {
    case unKnow                                          //无法回答
    case Music                                           //播放音乐
    case Hospital                                        //三甲医院
    case Registration                                    //预约挂号
    case Illness                                         //糖尿病
    case coffee                                          //咖啡
    case cafe                                            //咖啡馆
    case automobile                                      //汽车
    case cosmetics                                       //化妆品
    case watch                                           //手表
    case jewelry                                         //珠宝
    case bag                                             //箱包
    case clothing                                        //服装
    case wine                                            //酒类
    case yacht                                           //游艇
    case scenicSpot                                      //上海景点
    case cate                                            //小吃美食
    case shoppingCenter                                  //购物中心
    case homestay                                        //住宿
    case school                                          //学校
    case artTraining                                     //艺术培训
    case earlyEducation                                  //早教
    case engilihEducation                                //英语培训
    case healthExamination                               //体检
    case keepInGoodHealth                                //养生
    case artExhibition                                   //画展
    case animeExpo                                       //漫展
    case autoShow                                        //车展
    case weather                                         //天气
    case drinkCoffee                                     //喝咖啡
    case starbucks                                       //星巴克
    case discount                                        //优惠
    case restaurant                                      //餐厅
    case hotpot                                          //火锅
    case haidilao                                        //海底捞
    case meinian                                         //美年大健康
    case japanHealthExamination                          //日本体检
    case japanSenicSpot                                  //日本旅游景点
    case exhibition                                      //展会
    case university                                      //大学
    case universityInShanghai                            //上海大学
    case fudanUniversity                                 //复旦大学
    case LV                                              //路易威登
}

class ChatViewModel: NSObject {

    var question:Question!
    
    //收到用户消息
    func receiveMessage(message:String) {
        addMineChatModel(message: message)
        
        let answer = answerUserQusetion(message: message)
        
        addOtherChatModel(message: answer!)
        
        SpeakManager.shareManager.startSpeaking(message: answer!)
    }
    
    //添加用户的聊天信息
    private func addMineChatModel(message:String) {
        let model:ChatModel = ChatModel()
        model.isMineChat = true
        model.message = message
        chatMessageMArr.add(model)
    }
    
    //添加对方的聊天信息
    private func addOtherChatModel(message:String) {
        let model:ChatModel = ChatModel()
        model.isMineChat = false
        model.message = message
        chatMessageMArr.add(model)
    }
    
    private func answerUserQusetion(message:String) -> String? {

        if message.contains("三甲") || message.contains("医院") {
            question = .Hospital
        }else if message.contains("预约") || message.contains("挂号") {
            question = .Registration
        }else if message.contains("糖尿病") {
            question = .Illness
        }else if message.contains("唱歌") || message.contains("播放") || message.contains("音乐"){
            
            question = .Music
            
        }else if message == "咖啡" {
            question = .coffee
        }else if message.contains("咖啡馆") {
            question = .cafe
        }else if message == "汽车" {
            question = .automobile
        }else if message.contains("化妆品") {
            question = .cosmetics
        }else if message.contains("手表") {
            question = .watch
        }else if message.contains("珠宝") {
            question = .jewelry
        }else if message.contains("包") {
            question = .bag
        }else if message.contains("服装") {
            
            question = .clothing
            
        }else if message.contains("酒类") {
            question = .wine
        }else if message.contains("游艇") {
            question = .yacht
        }else if message.contains("上海景点") {
            question = .scenicSpot
        }else if message.contains("小吃") || message.contains("美食") {
            question = .cate
        }else if message.contains("住宿") {
            question = .homestay
        }else if message.contains("学校") {
            question = .school
        }else if message.contains("艺术培训") {
            question = .artTraining
        }else if message.contains("早教") {
            question = .earlyEducation
        }else if message.contains("英语培训") {
            question = .engilihEducation
        }else if message.contains("体检") {
            question = .healthExamination
        }else if message.contains("养生") {
            question = .keepInGoodHealth
        }else if message.contains("画展") {
            question = .artExhibition
        }else if message.contains("漫展") {
            question = .animeExpo
        }else if message.contains("车展") {
            
            question = .autoShow
            
        }else if message.contains("天气") {
            
            question = .weather
            
        }else if message.contains("喝咖啡") {
            
            question = .drinkCoffee
            
        }else if message.contains("星巴克") {
            
            question = .starbucks
            
        }else if message.contains("优惠") {
            
            question = .discount
            
        }else if message.contains("餐厅") {
            
            question = .restaurant
            
        }else if message.contains("火锅") {
            
            question = .hotpot
            
        }else if message.contains("海底捞") {
            
            question = .haidilao
            
        }else if message.contains("美年大健康") {
            
            question = .meinian
            
        }else if message.contains("日本体检") {
            
            question = .japanHealthExamination
            
        }else if message.contains("日本旅游景点") {
            
            question = .japanSenicSpot
            
        }else if message.contains("展会") {
            
            question = .exhibition
            
        }else if message.contains("大学") {
            
            question = .university
            
        }else if message.contains("上海大学") {
            
            question = .universityInShanghai
            
        }else if message.contains("复旦大学") {
            
            question = .fudanUniversity
            
        }else if message.contains("路易威登") || message.contains("LV") {
            
            question = .LV
            
        } else {
            question = .unKnow
        }
        
        
        
        
        switch question {
            
        case .unKnow:
            return "对不起,我不太明白您的意思"
            
        case .Music:
            return "主人，没问题啊，小艾我可是多才多艺的哦。请稍等"
            
        case .Hospital:
            return "\t上海交通大学医学院附属仁济医院\n\t上海交通大学医学院附属仁济医院\n\t上海交通大学医学院附属第九人民医院\n\t上海交通大学医学院附属瑞金医院\n\t上海交通大学医学院附属新华医院\n\t上海交通大学医学院附属上海儿童医学中心\n\t上海市第一人民医院\n\t"
            
        case .Registration:
            return "好的，我们为您提供三甲医院专家预约挂号服务，目前开通的城市有北京/上海/广州等地。只要您在真爱通上预订的挂号服务，我们还有陪诊人员当天为您现场服务！挂号+陪诊服务费100元。"
            
        case .Illness:
            return "糖尿病是一组以高血糖为特征的代谢性疾病。高血糖则是由于胰岛素分泌缺陷或其生物作用受损，或两者兼有引起。糖尿病时长期存在的高血糖，导致各种组织，特别是眼、肾、心脏、血管、神经的慢性损害、功能障碍。"
            
        case .coffee:
            return "\t雀巢咖啡\n\t星巴克\n\t格兰特咖啡\n\t乐维萨\n\t摩可纳\n\t奈斯派索\n\t麦斯威尔\n\t意利\n\tUCC悠诗诗\n\t麦馨\n\t"
            
        case .cafe:
            return "\t星巴克\n\t咖世家\n\t太平洋咖啡\n\t上岛咖啡\n\t迪欧咖啡\n\t两岸咖啡\n\t名典咖啡\n\t猫屎咖啡\n\t欧索米萝\n\t漫咖啡"
            
        case .automobile:
            return "\t劳斯莱斯\n\t宾利\n\t法拉利\n\t兰博基尼\n\t阿斯顿马丁\n\t布加迪\n\t帕加尼\n\t柯尼赛格\n\t迈巴赫\n\t迈凯轮"
            
        case .cosmetics:
            return "\t兰蔻\n\t雅诗兰黛\n\t资生堂\n\t迪奥\n\t香奈尔\n\t倩碧\n\t日本Sk-II\n\t碧欧泉\n\t赫莲娜\n\t伊丽沙白.雅顿"
            
        case .watch:
            return "\t百达翡丽\n\t爱彼\n\t宝珀\n\t江诗丹顿\n\t伯爵\n\t积家\n\t芝柏\n\t宝玑\n\t卡地亚\n\t劳力士"
            
        case .jewelry:
            return "\t卡地亚\n\t宝格丽\n\t蒂芙尼\n\t梵克雅宝\n\t海瑞·温斯顿\n\t伯爵\n\t宝诗龙\n\t格拉夫\n\t萧邦\n\t尚美巴黎"
            
        case .bag:
            return "主人，您很贴心哦，包治百病哟！奢侈品包包品牌：\n1、GUCCI 古奇；\n2、FENDI 芬迪；\n3、CELINE 赛琳；\n4、Versstar 范思哲；\n5、HERMES 爱马仕；\n6、SALVATORE FERRAGAMO 菲拉格幕；\n7、CARTIER 卡地亚；\n8、CD 迪奥；\n9、Chan excellentel 香奈儿；\n10、Louis Vuitton 路易威登   "
            
        case .clothing:
            return "\t路易·威登范思哲\n\t香奈尔\n\t迪奥\n\t古琦欧·古琦\n\t乔治·阿玛尼\n\t卡尔文·克莱恩\n\t普拉达\n\t华伦天奴\n\t巴宝丽"
            
        case .wine:
            return "\t至尊马爹利\n\t人头马路易十三\n\t轩尼诗李察\n\t帕图斯\n\t拉菲\n\t麦卡伦\n\t麦瑞泰基\n\t萨凯帕朗姆酒\n\t唐·培里侬香槟王\n\t巴黎之花"
        case .yacht:
            return "\t阿兹慕\n\t圣汐克\n\t法拉帝\n\t乐顺\n\t丽娃\n\t沃利\n\t公主\n\t博星\n\t博纳多\n\t意达马"
            
        case .scenicSpot:
            return "\t外滩\n\t南京路步行街\n\t上海迪士尼乐园\n\t东方明珠广播电视塔\n\t城隍庙\n\t田子坊\n\t新天地\n\t思南路\n\t中华艺术宫\n\t朱家角古镇"
            
        case .cate:
            return "上海海乃百川，好吃的东西可多了。上海十大著名小吃有：生煎馒头（生煎包）、南翔小笼、上海酱鸭、鲜肉月饼、四喜烤麸、鸽蛋圆子、油墩子、蟹壳黄、擂沙圆、排骨年糕"
            
        case .shoppingCenter:
            return "\t南京路步行街\n\t淮海路商业街\n\t徐家汇\n\t上海国金中心商场\n\t日上免税行（上海浦东机场）\n\t城隍庙旅游区\n\t月星环球港\n\t上海大悦城\n\tK11购物艺术中心"
            
        case .homestay:
            return "\t徐家汇中心真正上海风格客房\n\t上海纳美民宿\n\t上海法租界小日子民宿\n\t富民路老洋房\n\t淮海中路老洋房民宿\n\t洛登民宿\n\t黑弄·田子坊精品民宿\n\t北外滩阳光三房\n\t上海醒家民宿\n\t玉墅花园别墅"
            
        case .school:
            return "\t北京大学\n\t清华大学\n\t浙江大学\n\t复旦大学\n\t中国人民大学\n\t上海交通大学\n\t武汉大学\n\t南京大学\n\t中山大学\n\t吉林大学"
            
        case .artTraining:
            return "\t上海东方艺术培训学校\n\t上海新美苑艺术培训学校\n\t上海新汇艺术培训学校\n\t上海东方艺术培训学校\n\t上海市长宁区宋园路16号二楼\n\t上海电视艺术家协会小红帽艺术培训学校\n\t上海优棒打击乐艺术培训学校\n\t上海普陀区琴星少儿艺术培训学校\n\t上海飞儿文化艺术培训学校\n\t上海阿拉贝文化艺术培训学校\n\t上海市静安圣亿文化艺术培训学校"
            
        case .earlyEducation:
            return "\tUI.hearted有爱教育入户早教\n\t新爱婴东方园\n\t星优儿-宝贝学能启发中心\n\t美吉姆早教中心\n\t启稚摇篮早教中心\n\t想象乐创意中心\n\t小小运动馆\n\t金宝贝早教中心\n\t爱齐儿-蒙特梭利早教中心\n\t培正逗点早教中心"
            
        case .engilihEducation:
            return "\tEF英孚成人教育\n\t美联英语\n\t韦博国际英语\n\t汉普森英语\n\t华尔街英语\n\t新东方英语\n\t环球雅思\n\t韦博国际英语\n\t朗阁教育\n\t新航道"
            
        case .healthExamination:
            return "主人。您想在国内做还是国外做呢？我们都可以为您预约。上海地区知名的体检机构有：美年大健康、爱康国宾、瑞慈、美兆、名流、华山医院总院、同济大学附属天佑医院、第八人民医院、长海医院。日本东京健康诊疗院和奈良ground sould免疫研究所，可为您提供精密体检、基因体检、癌症风险评估、重金属检测、脑梗塞、心肌梗死发病风险检测、96种亚洲人群常用食物过敏反应检测以及免疫细胞活化疗、癌症预防、癌症术后康复治疗、浓缩细胞富含型脂肪面雕、隆胸、纤维芽细胞肌肤再生。"
            
        case .keepInGoodHealth:
            return "\t艾灸温灸\n\t药浴泡浴\n\t敷灸贴敷"
            
        case .artExhibition:
            return "\t中华艺术宫\n\t上海当代艺术馆\n\t上海龙美术馆\n\t上海多伦现代美术馆\n\t国际会展中心\n\t上海美术馆"
            
        case .animeExpo:
            return "\t2018上海游乐设备展览会 上海新国际博览中心 2018/4/19 2018/4/21\n\t2018年广州国际动漫艺术展览会 中国进出口商品交易会展馆 2018/6/8 2018/6/10\n\t2018第十七届中国VR/AR世界博览会 北京亦创国际会展中心 2018/6/28 2018/6/30\n\t上海动漫游戏博览会CCGEXPO 上海世博会展馆 2018/7/6 2018/7/10\n\t2018年中国国际数码互动娱乐展览会\n\t上海新国际博览中心 2018/7/27 2018/7/30 "
            
        case .autoShow:
            return "\t2018第十三届汽车灯具产业发展技术论坛暨第四届上海国际汽车灯具展览会(ALE)  地点：上海汽车会展中心 时间：2018年03月28日 - 03月29日\n\t2018上海国际节能与新能源汽车产业博览会 地点：上海新国际博览中心 时间：2018/07/18~2018/07/20\n\t2018年上海新能源车展 地点：上海虹桥-国家会展中心 时间：2018/09/20~2018/09/22\n\t2018上海汽配展 地点：国家会展中心(上海) 时间：2018年9月20-22日\n\t2018上海国际改装汽车展览会 地点：国家会展中心(上海) 时间：2018年9月20-22日"
   
        case .weather:
            return "主人，您好，今天4月2日，周一，上海天气，多云转阴 东南风微风，最低气温17度，最高温度24度。未来4田雨绵绵，6日最高气温将跌至14度。请灵活穿衣，谨防感冒。"
            
        case .drinkCoffee:
            return "好的，主人，根据您的习惯，为您推荐以下咖啡：星巴克咖啡、COSTA咖啡、太平洋咖啡。您想喝什么咖啡？"
        
        case .starbucks:
            return "小艾为您推荐最近的星巴克咖啡门店：张杨路501号第一八佰伴十楼新世纪影城内"
            
        case .discount:
            return "真爱通为您获取以下优惠：\t\n1、招商银行，799积分兑换1杯任意口味星巴克中杯手工调制饮品；\t\n2、建设银行，龙卡信用卡20000积分可兑换1杯星巴克大杯手工调制饮品；\t\n3、华夏银行，每月享2次积分兑换星巴克大杯手工调制饮品，第一次88积分即可兑换1杯，第二次8888积分兑换1杯。\t\n根据真爱通优惠比价算法，华夏银行最优惠。\t\n办理华夏银行信用卡，可享受更多优惠活动。请点击前往办理。"
            
        case .restaurant:
            return "主人，请问您想吃什么菜系？本帮菜、川菜、湘菜、火锅，还是其他？"
            
        case .hotpot:
            return "好的，主人，小艾为您推荐最近的火锅餐厅，有香天下、海底捞、哥老官。请问您想去哪家？"
            
        case .haidilao:
            return "好的，主人。小艾为您推荐最近的海底捞门店：张杨路620号中融恒瑞大厦六层"
            
        case .meinian:
            return "主人，美年现有以下体检套餐，请选择，具体了解：\t\n1、极速入职套餐 150元\t\n2、白领初级套餐  288元\t\n3、珍爱商务套餐  530元\t\n4、珍爱精英套餐  666元\t\n5、珍爱高端套餐 1122元\t\n6、珍爱尊享套餐 2599元\t\n7、珍爱父母套餐  766元\t\n8、深爱爸妈套餐  866元\t\n9、珍爱中老年套餐 1222元"
            
        case .japanHealthExamination:
            return "主人，我们可以为您预约日本体检，您的签证、机票、酒店、体检，我们都会有专人为您服务。请接通真人管家，我们竭诚为您服务。"
            
        case .japanSenicSpot:
            return "日本的国名含义为“日出之国”。你可以领略东京的都市繁华，饱览富士山的宁静壮阔，品味京都的古韵风情，感受现代与传统的交织融合。樱花、温泉、雪山、神社、海岛、宅文化……亚洲最具时尚魅力的现代化国度，多元化的人文与自然景观，让你体验无与伦比的东方魅力。\n小艾为您推荐10个日本必去的景点：\n1、东大寺\n东大寺大佛殿是世界现存最大的木结构建筑。殿内供奉着一尊16米高的卢舍那佛像，是世界上最大的青铜佛像。这里的鹿很多，很多游客给喂食鹿饼，小鹿一般不会顶撞人，非常温驯可爱。\n2、严岛神社\n严岛神社是使宫岛声名大噪的原因，也是宫岛名称的由来。此神社最初兴建于第6世纪，其中一部份结构是在水中，它的水中鸟居大门非常知名。后来此神社成为有权有势的平家的守护神社。铺展在严岛神社前的安芸滩约每6个小时就会满潮和退潮一次，退潮时，可从严岛神社步行至大鸟居。海边的美景分秒皆是变幻，严岛神社的庄严却历经千载不变。\n3、伏见稻荷大社\n京都的伏见稻荷大社乃是遍布日本全国3万余座稻荷神社的总社本宫。也是京都市内最古老的神社之一。这个神社是日本最美丽，最神圣的神社。日本人非常崇敬它。这里供奉的是保佑生意兴隆，五谷丰登的神明，每到正月或每月1日赶集的日子，这里就热闹非凡，本殿与牌坊都是红色的，代表万物丰收秋天的色彩。\n4、冲绳美丽海水族馆\n冲绳美丽海水族馆的名字在冲绳方言中是“清澈而美丽的海洋”之意，于2002年8月开放，是一座充分展示冲绳神秘莫测的海洋生物为主旨的大型水族馆。这里有各种千奇百怪的海洋生物在其中展示。其中又以鲸鲨和蝠鲼最具人气。\n5、富良野\n富田农场是北海道最早的花田之一，原来仅仅种植薰衣草的农场，在这几年主人的打理下，增加种植了金盏花、罂粟花等，逐渐形成了今日所见的彩虹花海。这里的薰衣草举世闻名，漫山遍野的薰衣草，如澎湃之浪，狠狠撞击了你的心房。那气势、那美艳，如果再不拍，那也真是一种罪过！\n6、小樽\n藤井樹，お元気ですか？（藤井树，你还好吗？）当听到这句响彻山谷雪原的呼唤时，你的心中是否会涌起一股暖流？小樽，日本著名电影导演岩井俊二代表作《情书》的拍摄地，那一条条有着美丽坡度的“坂道”，那冬日午后温柔拂面的街角夕阳，那城外寻找藤井树时声音回荡的空寂雪原，都曾经拨动了无数人的心弦。小城虽小，却装得下无数种故事，这些故事或浪漫，或悲伤，或沧桑，或厚重。如今小樽以旅游产业为主，美食、特产购物、历史风貌建筑、影视拍摄地观光、旅游摄影，所有关于城市旅游的要素均被这里兼收并蓄，小城散发着大魅力。\n7、金阁寺\n金阁寺是京都非常有名的寺庙。因其外以金箔装饰，民众遂以金阁殿称之，寺院也因此被唤作金阁寺。据说以金阁为中心的庭园表示极乐净土，被称作镜湖池的池塘与金阁相互辉映，是京都代表性的风景。8、银座\n银座自17世纪以来就及高格调闻名于世，是世界三大名街之一的繁华地区。拥有各种奢侈大牌，百年名店，是来东京不可不去的地方。入夜后，路边大厦上的霓虹灯变幻多端，构成了迷人的银座夜景。\n9、东京大学\n东京大学，日本第一所国立大学，亚洲乃至世界的顶级大学之一。本部在东京都文京区，占地40多公顷，有很多明治年代的老建筑。每年秋天校园成百上千的银杏树变黄之后，十分美丽壮观。另外，东京大学的校徽也是银杏。\n10、上野公园\n上野公园是日本最大的公园，也是东京的文化中心。园内有东京文化会馆、国立西洋美术馆，东京国立博物馆、东京都美术馆、上野动物园等等。这里一到春天，樱花便会如期开发，所以这里也是东京著名的赏樱场所之一。"
            
        case .exhibition:
            return "主人，最近上海4月份有如下展会，您可选择参加：\n1、4月2日-4日,上海新国际博览中心,2018第四届上海国际人工智能展览会\n2、4月5日-7日,上海世博展览馆,2018上海国际潮流玩具展\n3、4月6日-7日,光大会展中心,上海国际车展\n4、4月6日-8日,上海世博展览馆,2018第七届上海国际宠博会\n5、4月11日-12日,上海展览中心,2018上海国际奢侈品包装展\n6、4月11日-12日,国家会展中心（上海）,2018第79届全国药品交易会（上海药交会）\n7、4月20日-22日,上海新国际博览中心,2018中国国际高尔夫球博览会\n8、4月26日-29日,上海新国际博览中心，2018生活方式上海秀"
            
        case .university:
            return "主人，根据艾瑞深中国校友会网2018中国大学终合实力排行榜，前10位分别为：北京大学、清华大学、浙江大学、复旦大学、中国人民大学、上海交通大学、武汉大学、南京大学、中山大学、吉林大学。"
        case .universityInShanghai:
            return "主人，2017年上海十大本科学校排行版中，复旦大学问鼎2017上海本科院校排行版榜首，上海交通大学列第二，同济大学名列第三。\n2017上海十大本科学校排名：\n1、复旦大学\n2、上海交大\n3、同济大学\n4、华东师范\n5、华东理工\n6、上海大学\n7、东华大学\n8、上海财经\n9、上海理工\n10、上海师范"
            
        case .fudanUniversity:
            return "主人，复旦大学（Fudan University），简称“复旦”，位于中国上海，由中华人民共和国教育部直属，中央直管副部级建制，位列985工程、211工程、双一流A类，入选“珠峰计划”、“111计划”、“2011计划”、“卓越医生教育培养计划”，为“九校联盟”（C9）、中国大学校长联谊会、东亚研究型大学协会、环太平洋大学协会的重要成员，是一所世界知名、国内顶尖的全国重点大学。\n复旦大学创建于1905年，原名复旦公学，是中国人自主创办的第一所高等院校，创始人为中国近代知名教育家马相伯，首任校董为国父孙中山。校名“复旦”二字选自《尚书大传·虞夏传》名句“日月光华，旦复旦兮”，意在自强不息，寄托当时中国知识分子自主办学、教育强国的希望。1917年复旦公学改名为私立复旦大学；1937年抗战爆发后，学校内迁重庆北碚，并于1941年改为“国立”；1946年迁回上海江湾原址；1952年全国高等学校院系调整后，复旦大学成为以文理科为基础的综合性大学；1959年成为全国重点大学。2000年，原复旦大学与原上海医科大学合并成新的复旦大学。截至2017年5月，学校占地面积244.99万平方米，建筑面积200.20万平方米。\n根据中国校友会网2012中国大学全球亿万富豪校友排行榜：截至2011年，复旦大学拥有46位全球亿万富豪校友、21位中国政界英才校友、83位两院院士和60位杰出社会科学家校友。\n美国对其本土大学中外籍学生获得博士学位者（1999－2003）的本科毕业院校的统计数据显示，复旦大学毕业生获得美国学位的有626人，排全球前7位。"
            
        case .LV:
            return "主人，LouisVuitton路易·威登是法国历史上最杰出的皮件设计大师之一。于1854年在巴黎开了以自己名字命名的第一间皮箱店。一个世纪之后，路易·威登成为皮箱与皮件领域数一数二的品牌，并且成为上流社会的一个象征物。如今路易·威登这一品牌已经不仅限于设计和出售高档皮具和箱包，而是成为涉足时装、饰物、皮鞋、箱包、珠宝、手表、传媒、名酒等领域的巨型潮流指标。\n路易·威登女包有：手提包、手包及晚宴包、肩背包、迷你手袋、斜挎包、Nano手袋、Tate手袋、双肩包、Hobo手袋\n根据之前送给您女朋友礼物的品味和爱好来看，我为您推荐他家的Neverfull纯色款大号，这是改良的新花式，Tote包型，容量大，带娃的麻麻们最爱，适合老花审美障碍的重症患者。价格在1万左右。\nLV在上海有3家专卖店。\n1、恒隆广场旗舰店，南京西路1266号恒隆广场1楼136-138商铺\n2、浦东国金旗舰店，浦东新区世纪大道8号上海国金中心D座1层101商铺\n3、淮海中路旗舰店，卢湾区淮海中路222号力宝广场105商铺"
            
        case .none:
            return nil
            
        case .some(_):
            return nil
        }
        
        
    }
    
    func isMineChatCell(index:NSInteger) -> Bool! {
        let chatModel = chatMessageMArr[index] as! ChatModel
        return chatModel.isMineChat
    }
    
    func selectModelWith(index:NSInteger) -> String? {
        let chatModel = chatMessageMArr[index] as! ChatModel
        return chatModel.message
    }
    
    //MARK: -
    //MARK: -- 懒加载
    lazy var chatMessageMArr:NSMutableArray = {
        let chatMessageArray = NSMutableArray()
        return chatMessageArray
    }()
}

