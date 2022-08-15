# URLs Launcher

I work with multiple types of projects. For each project, I need specific access to various web resources. Due to the busyness of the day, I may lose certain tabs or close them accidentally. Additionally, I need to be able to organise and categorise new URLs quickly.

To speed up my work, I wrote a little D program that reads lists of *must-have* URLs in a text file, and launch these URLs in the default browser.

When I am working on Azure, I can run the following to open specific Azure resources.

```bash
$ rdmd urls-launcher.d -i <input-file-containing-urls-to-azure-resources>
```

Likewise, when I'm working on data analysis, I can run the program against a list of specific data sources to work on.

```bash
$ rdmd urls-launcher.d -i <input-file-containing-urls-to-data-sources>
```

etc.

## Justification

Why not use the Bookmark manager in Chrome and use the `Open All` option?

Well, I could.

With URLs-in-text-files approach, I can organise and categorise my URLs quickly.

As a bonus, I can share a copy of important URLs to my colleages as a text file.


## Installation
You must have a [D Language compiler](https://dlang.org/download.html). No other  installation are needed. 

## Input file

A input file should contains valid URLs separated by a new line. Examples are provided in the repo.

## Usage

Compile using a D lang compiler and run it using `-i <input folder>`. The input folder should contains JSON file. 

An example to compile using the `dmd` compiler and run it.

```bash
$ dmd urls-launcher.d
$ ./urls-launcher.exe -i <input-file>
```

Alternatively, if you have the dmd compiler installed, you can run this like a script using [`rdmd`](https://dlang.org/rdmd.html) tool.

```bash
$ rdmd urls-launcher.d -i <input-file>
```

Note

- If a line contains a invalid URL, the line will be skipped.
- An empty line will be skipped
- If a line contains multiple valid URLs, only the first one will be launched.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)