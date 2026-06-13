/*
 * Reference:
 *    https://www.gtkmm.org
 *
 * Requeriment
 *    libgtkmm-4.0-dev
 */
#include "mainwindow.hpp"

#include <gtkmm/application.h>

int main(int argc, char *argv[]) {
  auto app = MainWindow::create();
  return app->run(argc, argv);
}
