#include "mainwindow.hpp"

#include "lib.hpp"

#include <iostream>

static const char *ui_xml = R"XML(<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <requires lib="gtk" version="4.0"/>
  <object class="GtkApplicationWindow" id="MainWindow">
    <property name="title">GTKmm 4 GUI</property>
    <property name="default-width">400</property>
    <property name="default-height">200</property>
    <child>
      <object class="GtkBox">
        <property name="orientation">vertical</property>
        <property name="margin-start">0</property>
        <property name="margin-end">0</property>
        <property name="margin-top">0</property>
        <property name="margin-bottom">0</property>
        <child>
          <object class="GtkScrolledWindow">
            <property name="vexpand">true</property>
            <property name="hexpand">true</property>
            <child>
              <object class="GtkTextView" id="textEdit">
                <property name="editable">false</property>
                <property name="wrap-mode">word</property>
              </object>
            </child>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
)XML";

MainWindow::MainWindow() : Gtk::Application("org.example.Gtkmm4Sample") {}

Glib::RefPtr<MainWindow> MainWindow::create() {
  return Glib::RefPtr<MainWindow>(new MainWindow());
}

void MainWindow::on_activate() {
  try {
    auto builder = Gtk::Builder::create();
    // builder->add_from_file("gtk_mainwindow.ui");
    builder->add_from_string(ui_xml);

    auto window = builder->get_widget<Gtk::ApplicationWindow>("MainWindow");
    if (!window)
      throw std::runtime_error("Error building window.");

    auto textview = builder->get_widget<Gtk::TextView>("textEdit");
    if (!textview)
      throw std::runtime_error("Error building widget.");

    // Library - Test
    auto current_path = MyLib::path();
    auto buffer = textview->get_buffer();
    buffer->set_text(current_path);

    add_window(*window);
    window->present();

  } catch (const Glib::FileError &ex) {
    std::cerr << "FileError: " << ex.what() << std::endl;
  } catch (const Glib::MarkupError &ex) {
    std::cerr << "MarkupError: " << ex.what() << std::endl;
  } catch (const Gtk::BuilderError &ex) {
    std::cerr << "BuilderError: " << ex.what() << std::endl;
  } catch (const std::exception &ex) {
    std::cerr << "Exceção padrão: " << ex.what() << std::endl;
  }
}
