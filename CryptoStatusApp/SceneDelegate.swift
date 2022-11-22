//
//  SceneDelegate.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

/*
 Крипто кошелёк

 Я хочу приложение с 3мя вью контроллерами.

 Первый вью контроллер для авторизации, просто 2 текс Филда и кнопка. Захардкодьте где нибудь 2 строки для проверки что логин пароль введён верно. Или же сделайте логином паролем любую строку, но больше 4х символов. После успешного ввода логина и пароля происходит переход на втрой вью контроллер. Переход сделайте не просто через пуш вью контроллер (смена рутового вк у окна или у навигейшен контроллера). После успешного ввода логина/пароля, я или могу разлогиниться со 2/3 вк, и вернуться на экран авторизации. Или после закрытия приложения новый запуск начинался сразу со 2рого вк.

 2рой вк. Список всех монет сделанный через тейбл вью. На ячейке укажите хотя бы название монеты, ее стоимость, и ее изменение за сутки или час. Пока список монет грузится, я хочу что бы это как нибудь отображалось. Или спинер, или надпись об этом. Или еще что нибудь. Добавьте еще кнопку с возможностью сортировки изменения цены за сутки или за час (список или по возрастанию, или по убыванию). После Тапа на ячейку, осуществляется переход на 3тий вью контроллер.

 3тий вью контроллер. Просто детальная информация о монете. И кнопка логаут (кнопку можете разместить или на втором)

 Нетворк слой. Или вы берёте каждую монету из запроса https://data.messari.io/api/v1/assets/«тут монета»/metrics И через диспатч груп получаете готовый список сразу всех монет. Вот список проверенных монет: btc, eth, tron, luna, polkadot, dogecoin, tether, stellar, cardano, xrp. ЕЩЁ РАЗ ПОДЧЕРКНУ это API https://data.messari.io/api/v1/assets/_/metrics. Ни какое другое

 Самое главное, сделайте приложение как можно более расширяемым для новых фитч или изменений.

 НЕ используйте сториборды/ксибки для верстки. НЕ используйте сторонние библиотеки (кроме SnapKit, только ее можно). НЕ используйте mvc архитектуру. По причине того что она плохо расширяется

 Можете делать или локально, или через гит. Тут для меня разницы нет. Но если делаете через гит, мне нужна будет ссылка на ветку с готовой версией. Если решите использовать снап кит, то пжл установите его через поды. С пакет менеджером у меня проблемы
 */

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRouter: AppRouterProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }

        let mainWindow = UIWindow(windowScene: scene)
        mainWindow.overrideUserInterfaceStyle = .light

        window = mainWindow
        window?.makeKeyAndVisible()
        appRouter = AppRouter()
        appRouter?.showRootScreen()
    }

}
