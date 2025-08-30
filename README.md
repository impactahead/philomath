# Philomath

From markdown files to PDF book:

* Clickable table of contents
* Page markers
* Code blocks with syntax highlighting
* Support for the following elements: `h1`, `h2`, `h3`, `h4`, `ul`, `ol`, `quote`, and `code_block`.

## Quick start

You can just fork the [starter template](https://github.com/impactahead/philomath-starter-template) and write your own book.

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

You can also use config file, look at `book.yml` and then just call:

```ruby
Philomath.render_from_config(output_path: 'book.pdf')
```

### Cover image

You can also specify a cover image for your book. The best result you will achieve with `.png` file with dimensions `1540x1990`:

```ruby
chapters = [ ... ]

Philomath.render(chapters: chapters, output_path: 'book.pdf', cover_image: 'cover.png')

# or add cover_image attribute to config
```
