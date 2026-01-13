# XlsxMapper

**XlsxMapper** is a Python-based toolset designed to reverse-engineer Excel files (`.xlsx`) into human-readable formats and executable Python code. 

Instead of just extracting raw data, this project focuses on mapping the **structure**, **merges**, and **formatting** of spreadsheets, providing two outputs: a visual ASCII representation and a standalone Python script that can recreate the original file.

## Features

* **Reverse Engineering:** Converts an existing `.xlsx` into a Python script (`reconstruct.py`) using `openpyxl` commands.
* **ASCII Mapping:** Generates `.txt` files representing the spreadsheet layout, respecting merged cells and alignment.
* **Style Preservation:** Maps fonts, colors, borders, and text rotation.
* **Safety First:** Optimized for Python 3.13 with Type Hinting and protections against massive files.

## Project Structure

| File | Description |
| :--- | :--- |
| `create_xlsx_sample.py` | Generates a complex test spreadsheet with styles and merges. |
| `xlsx_to_txt.py` | Converts spreadsheet sheets into visual ASCII tables in `.txt`. |
| `transpiler.py` | The core engine. Reads `.xlsx` and writes a Python script. |

## Requirements

* Python 3.13+
* Openpyxl

```bash
pip install openpyxl