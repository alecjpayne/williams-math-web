# Williams mathematics website preview

This project is a proposed mathematics department website. The shared review site is:

https://mark-hopkins-at-williams.github.io/williams-math-web/

The existing Williams website at `hub.williams.edu/math` and the `math.williams.edu` redirect are separate. This project's preview work does not require changing either of them. Moving the approved site to `math.williams.edu` will be a later deployment decision with the Williams web administrator.

## Editing with colleagues

Start with [COLLABORATING.md](COLLABORATING.md). It explains the browser-only editing workflow and the few GitHub terms editors need.

The repository has two branches with different purposes:

- `source` contains the editable React/Vite project, article text, images, and page data. Make content and code changes here, usually through a small working branch and a pull request targeting `source`.
- `main` contains generated website files used by the existing GitHub Pages preview. Do not merge the source tree into this branch or treat its article copies as the editable master.

As inspected on September 27, 2026, GitHub publishes `main`, and the repository has no workflow to rebuild the website when `source` changes. This local revision proposes `.github/workflows/publish-preview.yml`, which builds `source` and publishes its output directly through GitHub Pages. That proposal requires an administrator to activate it; saving these files locally does not enable it. See [PREVIEW-SETUP.md](PREVIEW-SETUP.md).

## Local editing

Use Node.js 24 LTS. From `deptpage/`:

```sh
npm ci --ignore-scripts
npm run dev -- --host 127.0.0.1
```

Open the address printed in the terminal. The editor is at `/admin` on that same address. Save writes files on the computer running the editor; refresh the website tab to see changes.

If native file watching fails, the additional configuration supplied with this local revision uses polling:

```sh
npm run dev -- --config vite.local.config.js
```

On a Mac with dependencies already installed, `Start Local Website.command` starts that configuration. The launcher can use an existing Codex Node.js runtime or a normal `node` command. It does not install dependencies or publish online. See [LOCAL-PREVIEW.md](LOCAL-PREVIEW.md).

The editor's existing **Publish to live site** button is a legacy single-server operation: it commits local content, runs `npm run deploy` on that machine, and tries to push to its configured Git remote. It is not the GitHub preview workflow. Use Save for local editing and submit the changed source files through GitHub.

GitHub Pages serves the built site. It does not run the editor's Node.js backend. A shared form-based editor would need a separately hosted, authenticated editing service.

## Where content lives

| Content | File or folder |
| --- | --- |
| Article bodies | `articles/*.md` |
| Home page welcome text | `articles/welcome.md` |
| Home page headings, spotlight, caption | `deptpage/data/frontpage.json` |
| News titles, dates, teasers, article links | `deptpage/data/news.json` |
| People | `deptpage/data/people.json` |
| Courses and offerings | `deptpage/data/courses.json` |
| Colloquium events | `deptpage/data/colloquium.json` |
| Major requirements and planning paths | `deptpage/data/major.json` |
| Other pages | `deptpage/data/about.json`, `nonmajors.json`, `research.json`, `students.json` |
| Photos and other images | `images/` |
| Components and styling | `deptpage/src/` |

`deptpage/articles` and `deptpage/images` are links to the root folders. They are not separate copies. Use the root folders when editing through GitHub.

### Articles and news

Edit an existing Markdown file for a text change. To add a news item, create its article file and add an entry to the `articles` array in `deptpage/data/news.json`. For example, the existing AWM item uses:

```json
{
    "id": "article-awm-meet-greet-2026",
    "date": "September 22, 2026",
    "title": "AWM Student Chapter Meet & Greet, Thursday 9/24 at 2-3pm",
    "thumbnail": "/images/misc/awm-logo-thumb-lavender.jpg",
    "article": "articles/awm-meet-greet-2026.md",
    "teaser": "Join the AWM Student Chapter for its first Meet & Greet of the year in the Frank Morgan Library!"
}
```

Each ID should be unique. `article` points to a Markdown file. Optional `photo` and `thumbnail` point to images; the thumbnail should be square. An article file by itself does not add a link to the site's news listing.

### Page content blocks

Several page data files contain a `content` array. A text block specifies an article and optionally a heading or photo:

```json
{
    "title": "welcome to mathematics at williams!",
    "article": "articles/welcome.md"
}
```

Blocks appear in array order. Entries with a `component` field identify built-in React components; retain them unless changing the page implementation.

### People, courses, and events

Use the editor's corresponding forms where convenient. For direct file edits, match the structure of a current record in the relevant JSON file. Preserve unique IDs and the references between course offerings, catalog entries, and people. Photos go in the appropriate `images/` subfolder and are referenced as `/images/...`.

Course catalog icons are set in `deptpage/data/courses.json`; the current catalog form does not expose that field. `images/courseicons/icon-math.png` is an existing mathematics icon.

The major planning assistant uses `requirements` and `paths` in `deptpage/data/major.json`. Prerequisites must match existing requirement IDs. Study-away advice is in `articles/study-away.md`; there is no separate study-away equivalency data file in this project.

Academic content can legitimately mention computing, affiliated faculty, or research in other subjects. These references should be reviewed for accuracy rather than removed as template boilerplate.

## Build commands

From `deptpage/`:

- `npm run dev` starts the local development server and editor.
- `npm run build` builds the app into `dist/`; it does not publish it.
- `npm run preview` previews that app build locally. The full GitHub preview also needs the separate articles and images.
- `npm run deploy:preview` assembles the complete GitHub Pages preview, including articles, images, the project URL prefix, and page-route files. By default its output is `../../williams-math-web-preview`; `PREVIEW_OUT_DIR` can select a different output directory. The command does not upload anything.
- `npm run lint` runs the existing code lint rules.
- `npm run deploy` is the legacy root-directory build operation used by the old editor button. It replaces generated files in the parent project folder and is not part of the proposed review-site workflow.

The optional Linux service example in `deptpage/server/` is a generic template, not an active mathematics editing server. No server name, account, or production publishing location is assumed.
