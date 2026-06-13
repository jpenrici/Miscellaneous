# -*- coding: utf-8 -*-
"""
main.py

Objective: To create an xlsx file without libraries,
using only the OOXML standard contained in strings within the template.

References:
    https://www.w3.org/XML/Schema
    https://en.wikipedia.org/wiki/Office_Open_XML
    https://ecma-international.org/publications-and-standards/standards/ecma-376/

"""

import os
import zipfile
import template as templates


def create_xlsx(filename):
    # Temporary folder structure
    build_dir = "build"
    paths = [
        build_dir,
        os.path.join(build_dir, "_rels"),
        os.path.join(build_dir, "xl"),
        os.path.join(build_dir, "xl", "_rels"),
        os.path.join(build_dir, "xl", "worksheets"),
    ]

    for path in paths:
        os.makedirs(path, exist_ok=True)

    # Writing XML files
    files = {
        "[Content_Types].xml": templates.get_content_types(),
        "_rels/.rels": templates.get_package_rels(),
        "xl/workbook.xml": templates.get_workbook(),
        "xl/styles.xml": templates.get_styles(),
        "xl/_rels/workbook.xml.rels": templates.get_rels(),
        "xl/worksheets/sheet1.xml": templates.get_sheet_products(),
        "xl/worksheets/sheet2.xml": templates.get_sheet_summary(),
    }

    for rel_path, content in files.items():
        with open(os.path.join(build_dir, rel_path), "w", encoding="utf-8") as f:
            f.write(content)

    # Zipping the structure
    with zipfile.ZipFile(filename, "w", zipfile.ZIP_DEFLATED) as xlsx:
        for root, _, filenames in os.walk(build_dir):
            for f in filenames:
                file_path = os.path.join(root, f)
                archive_name = os.path.relpath(file_path, build_dir)
                xlsx.write(file_path, archive_name)

    print(f"Success! {filename} has been generated.")


if __name__ == "__main__":
    create_xlsx("example.xlsx")
