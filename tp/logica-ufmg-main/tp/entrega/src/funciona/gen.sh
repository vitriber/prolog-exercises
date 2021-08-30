#!/bin/bash
cat header.pl > qubic.pl
node gen_base.js >> qubic.pl
cat body.pl lan.pl >> qubic.pl
