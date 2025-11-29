# -*- coding: utf-8 -*-

# TO DO ------------------------
import sys
from typing import Optional, Any
from pathlib import Path

try:
    from PySide6.QtWidgets import (QApplication, QMainWindow, QWidget,
                                   QVBoxLayout, QTextEdit)
    from PySide6.QtCore import Qt
except ModuleNotFoundError as e:
    print(f"Module 'PySide6' is not installed! Error: {e}")
    sys.exit(0)
    

try:
    import cli_ctypes
except Exception as e:
    print(f"Module 'Wrapper' is not exists! Error: {e}")
    sys.exit(0)


class MainWindow(QMainWindow):
    def __init__(self, c_path_getter) -> None:
        super().__init__()
        self.c_path_getter = c_path_getter

        self.setWindowTitle("PySide6 C-Binding Viewer")
        self.setGeometry(100, 100, 600, 400)

        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        layout = QVBoxLayout(central_widget)

        self.text_edit = QTextEdit()
        self.text_edit.setReadOnly(True)
        self.text_edit.setFontPointSize(12)
        
        layout.addWidget(self.text_edit)

        self._display_c_binding_result()

    def _display_c_binding_result(self) -> None:
        result: str = self.c_path_getter()
        
        self.text_edit.setText(f"--- Ctypes Binding Result ---\n\n{result}")
        
        
def main():
    app = QApplication(sys.argv)
    window = MainWindow(get_path)
    window.show()
    
    sys.exit(app.exec())


if __name__ == '__main__':
  main()