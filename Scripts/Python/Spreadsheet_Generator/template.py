# -*- coding: utf-8 -*-

"""
template.py

Objective: To provide the structure for building an xlsx file according to the OOXML standard.

Note: Static template!
"""


def get_content_types():
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
    <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
    <Default Extension="xml" ContentType="application/xml"/>
    <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
    <Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
    <Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
    <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
</Types>"""

def get_workbook():
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
    <sheets>
        <sheet name="Products" sheetId="1" r:id="rId1"/>
        <sheet name="Summary" sheetId="2" r:id="rId2"/>
    </sheets>
</workbook>"""

def get_styles():
    """
    Defining styles:
    Index 0: Default (Normal)
    Index 1: Header (Bold font, Gray background, Thin borders)
    Index 2: Data (Thin borders only)
    """
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
    <fonts count="2">
        <font><sz val="11"/><name val="Calibri"/></font>
        <font><b/><sz val="11"/><name val="Calibri"/><color rgb="FFFFFFFF"/></font> 
    </fonts>
    <fills count="3">
        <fill><patternFill patternType="none"/></fill>
        <fill><patternFill patternType="gray125"/></fill>
        <fill><patternFill patternType="solid"><fgColor rgb="FF444444"/><bgColor indexed="64"/></patternFill></fill>
    </fills>
    <borders count="2">
        <border><left/><right/><top/><bottom/></border>
        <border><left style="thin"/><right style="thin"/><top style="thin"/><bottom style="thin"/></border>
    </borders>
    <cellXfs count="3">
        <xf numFmtId="0" fontId="0" fillId="0" borderId="0"/>
        <xf numFmtId="0" fontId="1" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/>
        <xf numFmtId="0" fontId="0" fillId="0" borderId="1" applyBorder="1"/>
    </cellXfs>
</styleSheet>"""

def get_sheet_products():
    """Sheet 1 with defined column widths and styles."""
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
    <cols>
        <col min="1" max="1" width="25" customWidth="1"/>
        <col min="2" max="3" width="15" customWidth="1"/>
    </cols>
    <sheetData>
        <row r="1">
            <c r="A1" t="inlineStr" s="1"><is><t>Product Name</t></is></c>
            <c r="B1" t="inlineStr" s="1"><is><t>Quantity</t></is></c>
            <c r="C1" t="inlineStr" s="1"><is><t>Unit Price</t></is></c>
        </row>
        <row r="2">
            <c r="A2" t="inlineStr" s="2"><is><t>Mechanical Keyboard</t></is></c>
            <c r="B2" s="2"><v>10</v></c>
            <c r="C2" s="2"><v>89.90</v></c>
        </row>
        <row r="3">
            <c r="A3" t="inlineStr" s="2"><is><t>Wireless Vertical Mouse</t></is></c>
            <c r="B3" s="2"><v>25</v></c>
            <c r="C3" s="2"><v>45.00</v></c>
        </row>
    </sheetData>
</worksheet>"""

def get_sheet_summary():
    """Sheet 2 with formulas and formatting."""
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
    <cols>
        <col min="1" max="1" width="30" customWidth="1"/>
        <col min="2" max="2" width="15" customWidth="1"/>
    </cols>
    <sheetData>
        <row r="1">
            <c r="A1" t="inlineStr" s="1"><is><t>Metric</t></is></c>
            <c r="B1" t="inlineStr" s="1"><is><t>Value</t></is></c>
        </row>
        <row r="2">
            <c r="A2" t="inlineStr" s="2"><is><t>Total Items in Stock</t></is></c>
            <c r="B2" s="2"><f>SUM(Products!B2:B3)</f><v>0</v></c>
        </row>
        <row r="3">
            <c r="A3" t="inlineStr" s="2"><is><t>Total Inventory Value</t></is></c>
            <c r="B3" s="2"><f>SUMPRODUCT(Products!B2:B3,Products!C2:C3)</f><v>0</v></c>
        </row>
    </sheetData>
</worksheet>"""

def get_rels():
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>
    <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/>
    <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>"""

def get_package_rels():
    return """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>"""