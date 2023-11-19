#!/bin/sh

# This script converts Postscript to PDF using ps2pdf

/usr/bin/ps2pdf - - | lp -d "Printer"