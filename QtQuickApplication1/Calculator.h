#include <QObject>

class Calculator : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(int m_num1 READ getNum1 WRITE setNum1 NOTIFY num1Changed)
    //Q_PROPERTY(int m_num2 READ getNum2 WRITE setNum2 NOTIFY num2Changed)
   
public:
    explicit Calculator(QObject* parent = nullptr)
    {

    }

    Q_INVOKABLE int add(int num1, int num2);

    /*int m_num1 = 0;
    int getNum1(){ return m_num1; }
    void setNum1(int numTem)
    {
        m_num1 = numTem;
    }

    int m_num2 = 0 ;
    int getNum2() { return m_num2; }
    void setNum2(int numTem)
    {
        m_num2 = numTem;
    }*/

//signals:
//    void num1Changed();
//    void num2Changed();
};