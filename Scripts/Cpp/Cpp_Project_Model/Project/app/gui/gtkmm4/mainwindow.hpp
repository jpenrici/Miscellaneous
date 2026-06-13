#pragma once

#include <gtkmm.h>

class MainWindow : public Gtk::Application {
public:
  MainWindow();
  ~MainWindow() override = default;

  static auto create() -> Glib::RefPtr<MainWindow>;

protected:
  void on_activate() override;
};
