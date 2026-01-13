# -*- coding: utf-8 -*-

import argparse
import json
from pathlib import Path
from analyzer import XlsxAnalyzer
from exporter_py import PythonScriptExporter
from exporter_txt import AsciiTableExporter
from typing import List, Dict, Any


def setup_args() -> argparse.Namespace:
    """
    Configures the Command Line Interface (CLI) arguments.
    """
    parser = argparse.ArgumentParser(description="XlsxMapper: Smart pipeline for XLSX analysis and export.")

    # Input can now be .xlsx or .json
    parser.add_argument("input", help="Path to the input file (.xlsx or .json)")

    parser.add_argument("--clean", action="store_true", help="Clear the output directory before execution")
    parser.add_argument("--meta", action="store_true", help="Export cell metadata to JSON")
    parser.add_argument("--ascii", action="store_true", help="Generate ASCII tables (.txt)")
    parser.add_argument("--transpile", action="store_true", help="Generate Python reconstruction script")
    parser.add_argument("--all", action="store_true", help="Execute all available export actions")

    return parser.parse_args()


def main() -> None:
    """
    Orchestrates the pipeline based on input file type and requested actions.
    """
    args = setup_args()
    input_path = Path(args.input)
    output_dir = Path(__file__).parent.parent / "output"
    output_dir.mkdir(parents=True, exist_ok=True)

    if not input_path.exists():
        print(f"[-] Error: Input file '{input_path}' not found.")
        return

    if args.clean:
        # Reusing logic to clean the output folder
        for item in output_dir.iterdir():
            if item.is_file():
                item.unlink()
        print("[*] Output directory cleaned.")

    # Determine input type
    is_xlsx = input_path.suffix.lower() == ".xlsx"
    is_json = input_path.suffix.lower() == ".json"

    # Action flags consolidation
    do_meta = args.meta or args.all
    do_ascii = args.ascii or args.all
    do_transpile = args.transpile or args.all

    # This dictionary will hold metadata for all sheets: { "SheetName": [CellMetadata, ...] }
    all_workbook_data: Dict[str, List[Any]] = {}

    if is_xlsx:
        print("[*] Input detected: Excel File. Starting Analysis...")
        analyzer = XlsxAnalyzer(input_path)
        sheet_names = analyzer.workbook.sheetnames

        for sheet_name in sheet_names:
            print(f"\n--- Processing Sheet: {sheet_name} ---")

            # Extract metadata for the current sheet
            cells = analyzer.get_cell_details(sheet_name)
            dims = analyzer.get_sheet_dimensions(sheet_name)

            all_workbook_data[sheet_name] = {
                "cells": cells,
                "dims": dims
            }

            if do_meta:
                json_out = output_dir / f"meta_{sheet_name}.json"
                analyzer.export_config_json(sheet_name, json_out)
                print("[+] Metadata saved to JSON.")

            if do_ascii:
                exporter = AsciiTableExporter(output_dir)
                exporter.generate_from_objects(sheet_name, cells)
                print("[+] ASCII Table generated.")

    elif is_json:
        print("[*] Input detected: JSON Metadata. Skipping Excel analysis...")
        with open(input_path, "r", encoding="utf-8") as f:
            json_data = json.load(f)

        # In this mode, we treat the JSON as a single-sheet workbook
        sheet_name = input_path.stem.replace("meta_", "")
        all_workbook_data[sheet_name] = json_data

        if do_ascii:
            txt_exporter = AsciiTableExporter(output_dir)
            txt_exporter.generate_from_json(sheet_name, input_path)

    else:
        print("[-] Error: Unsupported file format. Use .xlsx or .json")

    if do_transpile and all_workbook_data:
        print("[*] Generating Global Reconstruction Script...")
        py_exporter = PythonScriptExporter(output_dir)
        py_exporter.generate_full_workbook(all_workbook_data)


if __name__ == "__main__":
    main()
