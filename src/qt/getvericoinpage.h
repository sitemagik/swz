#ifndef GETsweetPAGE_H
#define GETsweetPAGE_H

#include <QWidget>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QByteArray>
#include <QTimer>

namespace Ui {
    class GetsweetPage;
}
class ClientModel;
class WalletModel;

QT_BEGIN_NAMESPACE
class QModelIndex;
QT_END_NAMESPACE

/** Trade page widget */
class GetsweetPage : public QWidget
{
    Q_OBJECT

public:
    explicit GetsweetPage(QWidget *parent = 0);
    ~GetsweetPage();

    void setModel(ClientModel *clientModel);
    void setModel(WalletModel *walletModel);

public slots:

// signals:

private:
    Ui::GetsweetPage *ui;
    ClientModel *clientModel;
    WalletModel *walletModel;

private slots:

};

#endif // GETsweetPAGE_H
