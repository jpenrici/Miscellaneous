#include "mainwindow.h"
#include "./ui_mainwindow.h"

#include "lib.hpp"

#include <print>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent), ui(new Ui::MainWindow) {
  ui->setupUi(this);

  // Simple test
  ui->textEdit->setText(get_path());
}

MainWindow::~MainWindow() { delete ui; }

auto MainWindow::get_path() -> QString {

  auto current_path = QString::fromUtf8(MyLib::path().c_str());
  qInfo() << "[PATH] : " << current_path;

  return current_path;
}
