# Philomath

From markdown files to PDF book:

* Clickable table of contents
* Page markers
* Code blocks with syntax highlighting
* Support for the following elements: `h1`, `h2`, `h3`, `h4`, `ul`, `ol`, `quote`, and `code_block`.

## Installation

Install library:

```bash
gem install philomath
```

## Usage

Prepare markdown files for your book and make it happen:

```ruby
chapters = [
  {
    name: 'Introduction',
    file_path: './book/introduction.md'
  },
  {
    name: 'Getting started',
    file_path: './book/getting_started.md'
  }
]

Philomath.render(chapters: chapters, output_path: 'book.pdf')
```
