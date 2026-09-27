# Editing the mathematics test website together

We want to refine the proposed mathematics website together before changing the current Williams site. The shared place to review it is:

https://mark-hopkins-at-williams.github.io/williams-math-web/

The existing site at `hub.williams.edu/math` and the `math.williams.edu` redirect should remain as they are during this review.

## The recommendation

Use one shared GitHub repository, with each person proposing small edits in their own working branch. A colleague reviews the proposal, accepts it into the `source` branch, and the shared test site is rebuilt.

For ordinary article edits, a browser is enough. Everyone does not need to download the website, install development software, or publish a separate copy.

**Setup status:** This is the proposed team workflow. As checked on September 27, 2026, the repository publishes built files from `main`; it does not automatically build changes to `source`. A proposed automation and setup instructions accompany this guide. The repository owner needs to activate them before accepted source changes will update the test site automatically. Until then, the owner must build and publish the preview manually.

## A few terms

| Term | Meaning here |
| --- | --- |
| Git | A system that records file changes and helps combine work from different people. |
| GitHub | The website where the shared project and its history live. |
| Repository | The shared project folder, together with its recorded history. |
| Branch | A separate line of edits. We use small working branches to prepare proposals. |
| Commit | A saved group of changes with a short explanation. |
| Pull request | A proposal asking to add one branch's changes to another. Colleagues can read and comment on it. |
| Merge | Accept a proposal into the shared branch. |
| Build and deploy | Turn the editable files into the website and update the hosted test site. |

A pull request is not a request to download anything. It is the place to review a proposed edit.

## Which version should we edit?

The same repository currently has two branches:

- **`source` is the editable master.** It contains articles, photos, page settings, and the website code. [Open the source branch](https://github.com/Mark-Hopkins-at-Williams/williams-math-web/tree/source).
- **`main` contains the built test site.** It is the version currently published by GitHub Pages. Its article copies may look editable, but changes made only there can disappear the next time the site is generated from `source`.

Always start from `source`, and direct your pull request back into `source`. GitHub may suggest `main` because it is currently the default branch; check the **base** branch before submitting. Do not merge the whole `source` branch into `main`—they contain different kinds of files.

Once the proposed automation is enabled, GitHub will build and publish directly from accepted changes in `source`. The preview keeps the same URL. The old generated `main` branch can remain as history.

## Make a small article edit in your browser

First, create your own GitHub account and ask the repository owner to add you as a collaborator. Accept the invitation. Your access to the Williams website is separate from your GitHub access.

1. Sign in to GitHub and open the [source branch](https://github.com/Mark-Hopkins-at-Williams/williams-math-web/tree/source).
2. Open the `articles` folder, then the article you want to change. For a first example, use [welcome.md](https://github.com/Mark-Hopkins-at-Williams/williams-math-web/blob/source/articles/welcome.md), which supplies the home page's welcome text.
3. Click the pencil icon to edit. If the source branch is protected and editing is unavailable, first create a working branch from `source` using the branch menu, then edit the file on that branch.
4. Change the text. Use **Preview** to check its formatting. This previews the article, not the full website layout.
5. Click **Commit changes**. Enter a short description, such as “Clarify the welcome paragraph.” Choose to create a new branch for this proposal if you are still on `source`. A name such as `welcome-wording` is fine. If you already created a working branch in step 3, commit to that working branch.
6. Create a pull request. Check that the destination, labeled **base**, is **`source`**. Write a sentence explaining the change. Submit the proposal and share its link with a colleague for review.
7. The reviewer checks the **Files changed** tab, discusses any questions, and merges the proposal into `source` when it is ready.
8. After automatic publishing is enabled, the **Actions** tab shows the build and deployment. When it succeeds, refresh the shared test site and check the changed page. Until that setup is enabled, ask the maintainer to publish the accepted change.

If two people edit the same sentence, GitHub may ask someone to resolve a conflict. That means choosing the intended combined wording. Keep proposals small and avoid replacing an entire file with an old copy.

## What can I change?

| Change | Where it belongs |
| --- | --- |
| An existing article's paragraphs, lists, or links | Its file in `articles/` |
| Home page welcome text | `articles/welcome.md` |
| A news headline, date, or teaser | `deptpage/data/news.json` |
| Add a news article | A new article file plus an entry in `deptpage/data/news.json` |
| Home page heading or photo caption | `deptpage/data/frontpage.json` |
| Faculty information | `deptpage/data/people.json` |
| A picture | `images/`, plus the corresponding reference in the page data |
| Layout, colors, or interactive behavior | `deptpage/src/`; ask for help if needed |

Markdown article files are mostly ordinary text. For example:

```text
This is a paragraph.

**This is bold.**

## A section heading

- First item
- Second item

[Williams College](https://www.williams.edu/)
```

Page settings use JSON, which is more sensitive to punctuation. Use the local form-based editor or ask a maintainer to help with those files if preferred.

## If you prefer the local editor

The editor you tried on your Mac remains useful, especially for photos and structured forms. Local editing is optional; it adds a few synchronization steps.

For ongoing work, use a **clone**, which is a connected working copy, rather than repeatedly downloading ZIP files. GitHub Desktop provides buttons for these steps:

1. Clone the shared repository once. Switch to `source`, fetch the latest changes, and pull them.
2. Create a working branch from `source` before editing.
3. Install Node.js 24 LTS and the project packages once. Run the local site and make changes through `/admin`. The included local preview guide explains this.
4. Click **Save** in the editor. That changes the local article, data, and image files.
5. In GitHub Desktop, review the changed files, write a short commit message, and commit to your working branch. Do not include `node_modules`, build output, credentials, or unrelated local files.
6. Use **Publish branch** or **Push origin** to upload your branch, then open a pull request whose base is `source`.
7. Review and merge as above. Fetch and pull the latest `source` before starting the next task.

The original ZIP is an unconnected snapshot. Existing edits made in it can be carried over: start a fresh working branch, compare the files you changed with the current `source` version, and apply just your edits. Avoid copying the whole ZIP over the shared project, since others may have updated it in the meantime.

The local editor's **Publish to live site** button belongs to an older server workflow. It does not perform this GitHub review-and-preview process. Use **Save**, then submit the changed files through GitHub.

## Can we all use the form editor online?

Not on GitHub Pages alone. GitHub Pages hosts the finished website; this project's editor also needs a running Node.js server that can save files. The existing production build omits the admin interface.

A shared authenticated editor could be added later, with its Save action creating reviewed GitHub changes. That would be another setup task. For now, browser editing on GitHub is the simplest shared option; no command line is needed for article corrections.

## Review and eventual launch

The preview is publicly accessible. Anyone can read the test site and this public repository; changing them requires the appropriate account permissions. A search-engine exclusion is not a password.

The recommended arrangement uses one shared preview of the latest accepted changes. A pending proposal shows a text comparison and Markdown preview; it does not get a separate full-site URL. A maintainer can preview it locally before accepting it. Separate per-proposal websites could be added later if the team needs them.

When the department is ready to launch, coordinate hosting and the `math.williams.edu` address with the Williams web administrator. The GitHub preview does not itself replace the current Williams site or change that redirect.

## Further help

- [GitHub's guide to editing files](https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files)
- [GitHub Desktop](https://desktop.github.com/)
- [Node.js download](https://nodejs.org/en/download)
- [What GitHub Pages hosts](https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages)
- Repository owner: see `PREVIEW-SETUP.md` for the proposed one-time setup.
