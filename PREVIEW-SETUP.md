# Proposed setup for the shared mathematics preview

Audience: the GitHub repository owner or a maintainer with settings access.

**Status: prepared locally, not installed or enabled on GitHub.** The build has been tested locally; the GitHub-hosted workflow and deployment still need validation after setup. These instructions apply to `Mark-Hopkins-at-Williams/williams-math-web`, its `source` branch, and its existing GitHub Pages preview URL. They do not configure Williams hosting or DNS.

## What exists today

Inspection on September 27, 2026 found:

- The default `main` branch contains generated static website files.
- The `source` branch contains the editable React/Vite app and content. Its head is `257692916daad92fae819a6d0d1d7671bcdbf907`, matching the downloaded ZIP.
- The Actions page shows the built-in `pages-build-deployment` workflow publishing `main`.
- The source tree contains no workflow that builds accepted source edits into the preview.
- `deptpage/deploy-preview.sh` builds for `/williams-math-web/` and copies articles and images, including the targets of their directory links. Historically its output was a separate working checkout of the same repository's `main` branch.

These two branches are not ordinary draft/release versions of the same file tree. Do not merge all of `source` into `main`.

## Proposed behavior

Accept an edit into `source` → build the complete preview → deploy it directly to GitHub Pages at the existing URL.

The proposed workflow is `.github/workflows/publish-preview.yml`. Pull requests targeting `source` get a build check but do not deploy. Pushes to `source`, including merged proposals, build and deploy. Publishing does not write generated files back into `main` or require a personal access token.

A separate deploy job receives Pages publishing permission. The build job has read-only repository permission. The workflow has no Williams server credentials and no custom-domain configuration.

## One-time owner setup

1. Review the accompanying changes on a working branch based on the current `source` branch. Keep any recent source changes or colleagues' edits. The setup package contains selected setup/documentation files, not a replacement copy of all department content.
2. Add the workflow, updated `deptpage/deploy-preview.sh`, and updated `deptpage/package.json` through a pull request with **base: source**. The remaining files clean up inherited examples and provide editor documentation. Keep `package-lock.json` as the dependency lockfile; no dependency versions have been changed.
3. In the repository's **Settings → Pages → Build and deployment**, change **Source** to **GitHub Actions**. This selects how the existing preview is published; keep the custom-domain field unset for this test site.
4. In **Settings → Environments → github-pages**, inspect the deployment branch rules. Allow the `source` branch. Existing rules may allow only `main`; they must match the new publishing branch. Retain any reviewer policy the team wants.
5. Merge the setup proposal into `source`. This push starts the proposed workflow. If the setup was merged before changing the Pages settings, re-run the failed workflow from **Actions** after the settings are ready, or make a subsequent source commit.
6. Check both **Build preview** and **Publish shared preview** in Actions. Visit the existing preview URL and verify the home page, images, an article, and a directly opened interior URL such as `/williams-math-web/courses/`.
7. Invite the editors as collaborators using their individual GitHub accounts. Give them permission to create working branches and proposals. Choose who will review and merge changes.
8. Consider making `source` the default branch, since it is the editable project. Then consider a branch rule requiring pull requests and the **Build preview** check before merging, with one review if desired. Let a check run successfully before selecting it as a required check. Browser editors can create a working branch before editing if protected-branch rules prevent direct edits.
9. Share `COLLABORATING.md` or its standalone HTML version. Tell editors when automatic publishing has been enabled; until then, edits to `source` do not automatically update the shared preview.

The workflow intentionally has no manual-dispatch trigger: while `main` remains the default branch, a workflow present only on `source` is not a dependable place for GitHub's Run workflow button. Normal pushes to `source` and pull requests targeting it are the supported triggers.

## Local build verification

Install Node.js 24 and project dependencies, then run from `deptpage/`:

```sh
npm ci --ignore-scripts
npm run deploy:preview
```

The output defaults to a sibling directory named `williams-math-web-preview`. Choose a scratch directory instead by setting `PREVIEW_OUT_DIR`; the script replaces that directory's generated assets, articles, images, and route files. Do not point it at an editable project folder.

The build includes `/williams-math-web/` asset paths, article and image copies, route entry points, and `robots.txt` requesting no indexing. The output contains no editor or source repository credentials. Preview pages remain publicly accessible.

## Fallback while keeping the current publication arrangement

If the owner prefers to keep Pages publishing `main`, they can continue building from accepted `source` changes and copying the generated output into a clean checkout of `main`, then commit and push that generated output. Keep source edits recorded on `source` first. Do not edit only the generated branch, and do not push source files into it.

This is a maintainer task until automated. Editors can still propose article edits through the browser, with the maintainer publishing after acceptance.

To back out of the proposed publishing setup, an administrator can disable the new workflow and restore Pages publishing from `main` at the repository root. That restores the version last built into `main`, which may be older; record or update the fallback version first if needed.

## What was cleaned up locally

- Replaced inherited README instructions and examples with mathematics content and an explicit preview workflow.
- Removed the unused `build:ephs` script and its ignored output folder.
- Replaced inherited server/account names with a generic, optional editing-service example.
- Updated course-ID comments and base-path examples.
- Removed the unused `wics` image-upload category.
- Made the preview output location configurable for the GitHub runner and quoted its paths.
- Made the Mac launcher locate the current user's Codex runtime instead of a named user's home directory.

Actual academic references to computing, faculty affiliations, alumni, and publications are retained. They are content, not inherited publishing configuration.

The local editor's old Publish button remains a legacy single-server operation. It is documented as outside the GitHub preview workflow; it has not been repurposed as a remote GitHub publisher.

## References

- [Current source branch](https://github.com/Mark-Hopkins-at-Williams/williams-math-web/tree/source)
- [Existing Pages build history](https://github.com/Mark-Hopkins-at-Williams/williams-math-web/actions)
- [Configure the Pages publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
- [Custom GitHub Pages workflows](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
