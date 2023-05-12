#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "calculator.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    //app.setWindowIcon();
    QQmlApplicationEngine engine;
    Calculator calculator;
    //qmlRegisterType<Calculator>("Calculator", 1, 0, "calculator");//这样注册不行

    engine.rootContext()->setContextProperty("calculator", &calculator);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject* root = engine.rootObjects().first();
    QObject* button = root->findChild<QObject*>("addBtn");
    if (button)
        button->setProperty("color", "#FF0000");

    return app.exec();
}
