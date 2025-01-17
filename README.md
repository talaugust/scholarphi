# Scholar Reader

**This is a forked version of ScholarPhi that's being used to experiment
  with techniques for making medical literature more approachable. Some of
  documentation may accordingly be out of date.**

The user interface, API, and data processing scripts for an 
augmented PDF reader application.

This repository hosts code for three subprojects: the user 
interface, API, and data processing scripts.  To learn about 
each of these projects and how to run the code for each of 
them, see the `README.md` file in the relevant directory.

Key directories include:

* `api/`: the web API that provides data about entities in 
papers and bounding boxes for those entities.
* `data-processing/`: a set of data processing scripts that 
extract entities and their bounding boxes from papers.
* `ui/`: the user interface for the augmented PDF reader.

## Quick Start

Make sure you have [Docker](https://docker.com) installed, then run:

```bash
docker compose up --build
```

Once that command completes you should be able to navigate to 
[http://localhost:8080/?file=/paper/LDH_surgery.pdf](http://localhost:8080/?file=/paper/LDH_surgery.pdf).

See [ui/README.md](ui/README.md) for more details on how to use the reader.

## Style guidelines

The code in this directory roughly follows the following 
style guidelines:

* Python: `mypy` for typing, `black` for formatting, 
`pylint` for linting, and `pytest` for testing.  
Configurations for each can be found in the VSCode 
`.vscode/settings.json` file for Python subprojects.

* Node: Typescript, with Jest for tests, and Prettier for 
formatting. For linting Typescript, see the `tslint.json` 
specs in the Typescript subprojects.

Styling also roughly follows the guides for
[React](https://github.com/allenai/wiki/wiki/React-Style-Guide) 
and 
[CSS](https://github.com/allenai/wiki/wiki/CSS-Style-Guide) 
for Allen AI engineering (see the 
[wiki](https://github.com/allenai/wiki/wiki/Getting-Started)), 
where it makes sense to use these guides.

## Contributors

* [Andrew Head](mailto:andrew.head@berkeley.edu)
* [Kyle Lo](mailto:kylel@allenai.org)
* [Sam Skjonsberg](mailto:sams@allenai.org)
* [Dan Weld](mailto:danw@allenai.org)
* [Marti Hearst](mailto:hearst@berkeley.edu)
* [Zachary Kirby](mailto:zkirby@berkeley.edu)
* [Vivek Aithal](mailto:vivek_aithal@berkeley.edu)
* [Jocelyn Sun](mailto:jocelyn.z.sun@berkeley.edu)
* [Dongyeop Kang](mailto:dongyeopk@berkeley.edu)


## License

This project is licensed under the Apache License 2.0.  It
is aggregate software that calls
[GhostScript](https://ghostscript.com/), which is
distributed under the Affero GNU Public License (AGPL). The
GhostScript binaries and source code are available upon
request. You can learn more about the GhostScript AGPL
License [here](https://ghostscript.com/license).
