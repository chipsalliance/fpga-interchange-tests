#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2021-2022  F4PGA Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

# -- General configuration ------------------------------------------------

extensions = []

templates_path = ['_templates']

source_suffix = '.rst'

master_doc = 'index'

project = 'fpga-interchange-tests'
copyright = '2020, Various'
author = 'Various'

# The short X.Y version.
version = '0.1'
# The full version, including alpha/beta/rc tags.
release = '0.1'

language = None

exclude_patterns = []

pygments_style = 'default'

todo_include_todos = False

# -- Options for HTML output ----------------------------------------------

html_show_sourcelink = True

html_theme = 'sphinx_f4pga_theme'

html_theme_options = {
    'repo_name': 'chipsalliance/fpga-interchange-tests',
    'github_url' : 'https://github.com/chipsalliance/fpga-interchange-tests',
    'globaltoc_collapse': True,
    'color_primary': 'indigo',
    'color_accent': 'blue',
}

# -- Options for HTMLHelp output ------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = 'fpga-interchange-tests'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {}

latex_documents = [
    (
        master_doc, 'fpga-interchange-tests.tex',
        'fpga-interchange-tests Design support status', 'Various', 'manual'
    ),
]

# -- Options for manual page output ---------------------------------------

man_pages = [
    (
        master_doc, 'fpga-interchange-tests',
        'fpga-interchange-tests Design support status',
        [author], 1
    )
]

# -- Options for Texinfo output -------------------------------------------

texinfo_documents = [
    (
        master_doc, 'fpga-interchange-tests',
        'fpga-interchange-tests Design status',
        author, 'fpga-interchange-tests',
        'FPGA interchange design support status',
        'Miscellaneous'
    ),
]
