# -*- coding: utf-8 -*-

import openpyxl
from openpyxl.styles import Alignment, Font, PatternFill, Border, Side
from pathlib import Path

def create_complex_sample():
    """
    Generates a complex XLSX to stress-test the XlsxMapper pipeline.
    Includes: Multi-sheet, cross-sheet formulas, nested merges, and various colors.
    """
    wb = openpyxl.Workbook()
    
    # --- SHEET 1: Financial Summary ---
    ws1 = wb.active
    ws1.title = "Financial_Summary"
    
    # Styles
    header_fill = PatternFill(start_color="4F81BD", fill_type="solid") # Blue
    header_font = Font(bold=True, color="FFFFFF")
    border_thick = Side(border_style="thick", color="000000")
    
    # Merged Header
    ws1.merge_cells("A1:D1")
    ws1["A1"] = "ANNUAL BUDGET 2026"
    ws1["A1"].fill = header_fill
    ws1["A1"].font = header_font
    ws1["A1"].alignment = Alignment(horizontal="center")
    
    # Data and Formulas
    ws1["A2"], ws1["B2"] = "Category", "Amount"
    ws1["A3"], ws1["B3"] = "Marketing", 5000
    ws1["A4"], ws1["B4"] = "Development", 12000
    
    # Formula cell
    ws1["A5"] = "TOTAL"
    ws1["B5"] = "=SUM(B3:B4)"
    ws1["B5"].font = Font(bold=True)
    ws1["B5"].border = Border(top=border_thick)

    # --- SHEET 2: Matrix_Layout ---
    ws2 = wb.create_sheet("Matrix_Layout")
    
    # Vertical Merge
    ws2.merge_cells("A2:A10")
    ws2["A2"] = "SIDEBAR NAVIGATION"
    ws2["A2"].alignment = Alignment(textRotation=90, vertical="center", horizontal="center")
    ws2["A2"].fill = PatternFill(start_color="E1E1E1", fill_type="solid") # Grey
    
    # Horizontal Merge with specific color
    ws2.merge_cells("C3:F3")
    ws2["C3"] = "SECTION TITLE"
    ws2["C3"].fill = PatternFill(start_color="FFC000", fill_type="solid") # Orange/Gold
    ws2["C3"].alignment = Alignment(horizontal="center")

    # Cross-Sheet Formula: Reference value from Sheet 1
    ws2["B1"] = "Reference from Summary:"
    ws2["C1"] = "=Financial_Summary!B5" 
    
    # Border Stress Test
    red_side = Side(border_style="medium", color="FF0000")
    ws2["D5"].value = "RED BOX"
    ws2["D5"].border = Border(top=red_side, bottom=red_side, left=red_side, right=red_side)

    # Save
    output_path = Path(__file__).parent.parent / "test_xlsx" / "complex_test.xlsx"
    output_path.parent.mkdir(parents=True, exist_ok=True)
    wb.save(output_path)
    print(f"[+] Complex sample created at: {output_path}")

if __name__ == "__main__":
    create_complex_sample()