# Blur Image with Software/Hardware Codesign

This repository contains code to get a picture from software and blur it on a 8051 microprocessor.

## How to Run

```bash
sdcc blur.c
cpp -P blur.fdl >temp.fdl
/opt/gezel/bin/gplatform temp.fdl 
```
