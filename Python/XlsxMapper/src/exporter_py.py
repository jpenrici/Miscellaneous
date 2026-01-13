# -*- coding: utf-8 -*-

from pathlib import Path
from typing import Dict, Any


class PythonScriptExporter:
    """Generates a master Python script to mirror the original XLSX workbook."""

    def __init__(self, output_dir: Path):
        self.output_dir = output_dir

    def generate_full_workbook(self, workbook_data: Dict[str, Dict[str, Any]]) -> None:
        """
        Creates a single script. 
        Expected format: { "SheetName": {"cells": [...], "dims": {...}} }
        """
        script = [
            "# -*- coding: utf-8 -*-",
            "import openpyxl",
            "from openpyxl.styles import Alignment, Font, PatternFill, Border, Side\n",
            "def rebuild():",
            "    wb = openpyxl.Workbook()",
            "    # Cleanup default sheet",
            "    if 'Sheet' in wb.sheetnames: wb.remove(wb['Sheet'])\n"
        ]

        for sheet_name, content in workbook_data.items():
            script.append(f"    # --- Reconstructing Sheet: {sheet_name} ---")
            script.append(f"    ws = wb.create_sheet('{sheet_name}')")

            # Apply Dimensions
            dims = content.get("dims", {})
            for col, width in dims.get("cols", {}).items():
                script.append(f"    ws.column_dimensions['{col}'].width = {width}")
            for row, height in dims.get("rows", {}).items():
                script.append(f"    ws.row_dimensions[{row}].height = {height}")

            processed_merges = set()
            cells = content.get("cells", [])

            for c in cells:
                # Support both Dict (from JSON) and Dataclass
                data = c if isinstance(c, dict) else c.__dict__
                coord = data['coordinate']

                # 1. Formulas (using single quotes) and Values (using triple quotes for safety)
                if data.get('formula'):
                    script.append(f"    ws['{coord}'].value = '{data['formula']}'")
                elif data.get('value') is not None:
                    val = data['value']
                    formatted_val = f'"""{val}"""' if isinstance(val, str) else val
                    script.append(f"    ws['{coord}'].value = {formatted_val}")

                # 2. Borders
                if data.get('borders'):
                    b_parts = [f"{s}=Side(border_style='{d['style']}', color='{d['color']}')"
                               for s, d in data['borders'].items()]
                    script.append(f"    ws['{coord}'].border = Border({', '.join(b_parts)})")

                # 3. Fill and Style
                if data.get('fill_color'):
                    script.append(
                        f"    ws['{coord}'].fill = PatternFill(start_color='{data['fill_color']}', fill_type='solid')")
                if data.get('font_bold'):
                    script.append(f"    ws['{coord}'].font = Font(bold=True)")
                if data.get('alignment') != 'left':
                    script.append(f"    ws['{coord}'].alignment = Alignment(horizontal='{data['alignment']}')")

                # 4. Merges (Applied once per range)
                m_range = data.get('merge_range')
                if data.get('is_merged') and m_range not in processed_merges:
                    script.append(f"    ws.merge_cells('{m_range}')")
                    processed_merges.add(m_range)

            script.append("")  # Spacer between sheets

        script.extend([
            "    wb.save('full_reconstructed_file.xlsx')",
            "    print('Workbook reconstructed successfully!')",
            "\nif __name__ == '__main__':",
            "    rebuild()"
        ])

        with open(self.output_dir / "full_reconstruct.py", "w", encoding="utf-8") as f:
            f.write("\n".join(script))
