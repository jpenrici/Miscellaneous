# -*- coding: utf-8 -*-

import argparse
import json
import sys
import shutil
from pathlib import Path
from analyzer import XlsxAnalyzer
from exporter_py import PythonScriptExporter
from exporter_txt import AsciiTableExporter
from typing import List, Dict, Any
from create_test import create_sample


def setup_args() -> argparse.Namespace:
    """
    Configures the Command Line Interface (CLI) arguments.
    """
    parser = argparse.ArgumentParser(description="XlsxMapper: Smart pipeline for XLSX analysis and export.")

    # Input made optional at parser level to allow --sample without a file path
    parser.add_argument("input", nargs="?", help="Path to the input file (.xlsx or .json)")

    parser.add_argument("--clean", action="store_true", help="Clear the output directory before execution")
    parser.add_argument("--meta", action="store_true", help="Export cell metadata to JSON")
    parser.add_argument("--ascii", action="store_true", help="Generate ASCII tables (.txt)")
    parser.add_argument("--transpile", action="store_true", help="Generate Python reconstruction script")
    parser.add_argument("--all", action="store_true", help="Execute all available export actions")

    # Testing Flags
    parser.add_argument("--sample", action="store_true", help="Creates a complex sample XLSX file for testing")
    parser.add_argument("--test", action="store_true", help="Automatic run: Creates sample and runs --all on it")

    return parser.parse_args()


def main() -> None:
    """
    Orchestrates the pipeline based on input file type and requested actions.
    """
    args = setup_args()

    # 1. Directory Setup
    base_dir = Path(__file__).parent.parent
    output_dir = base_dir / "output"
    img_output_dir = output_dir / "images"
    test_dir = base_dir / "test_xlsx"

    output_dir.mkdir(parents=True, exist_ok=True)
    test_dir.mkdir(parents=True, exist_ok=True)

    # 2. Sample Generation
    # If --test is used, we force the creation of the sample first
    if args.sample or args.test:
        print("[*] Action: Generating XLSX sample...")
        create_sample()
        if args.sample and not args.test:
            print("[+] Sample created. Exiting.")
            return

    # 3. Input Path Logic
    if args.test:
        input_path = test_dir / "sample.xlsx"
    elif args.input:
        input_path = Path(args.input)
    else:
        print("[-] Error: No input file specified. Use --sample to create one or provide a path.")
        sys.exit(1)

    if not input_path.exists():
        print(f"[-] Error: Input file '{input_path}' not found.")
        return

    # 4. Cleanup Phase
    if args.clean or args.test:
        print("[*] Cleaning output directory...")
        if output_dir.exists():
            shutil.rmtree(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        img_output_dir.mkdir(parents=True, exist_ok=True)

    # 5. Pipeline Logic
    do_meta = args.meta or args.all or args.test
    do_ascii = args.ascii or args.all or args.test
    do_transpile = args.transpile or args.all or args.test

    # This dictionary will hold metadata for all sheets: { "SheetName": [CellMetadata, ...] }
    all_workbook_data: Dict[str, List[Any]] = {}

    # Determine input type
    is_xlsx = input_path.suffix.lower() == ".xlsx"
    is_json = input_path.suffix.lower() == ".json"

    if is_xlsx:
        print("[*] Input detected: Excel File. Starting Analysis...")
        analyzer = XlsxAnalyzer(input_path)
        sheet_names = analyzer.workbook.sheetnames

        for sheet_name in sheet_names:
            print(f"\n--- Processing Sheet: {sheet_name} ---")

            # Extract metadata for the current sheet
            cells = analyzer.get_cell_details(sheet_name)
            dims = analyzer.get_sheet_dimensions(sheet_name)

            # Extract Assets (Images)
            assets = analyzer.get_sheet_assets(sheet_name, img_output_dir)

            all_workbook_data[sheet_name] = {
                "cells": cells,
                "dims": dims,
                "assets": assets
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
        all_workbook_data[sheet_name] = {"cells": json_data, "dims": {}, "assets": []}

    else:
        print("[-] Error: Unsupported file format. Use .xlsx or .json")

    if do_transpile and all_workbook_data:
        print("\n[*] Generating Global Reconstruction Script...")
        py_exporter = PythonScriptExporter(output_dir)
        py_exporter.generate_full_workbook(all_workbook_data)
        print(f"[+] Success: Script generated in {output_dir}/full_reconstruct.py")


if __name__ == "__main__":
    main()
