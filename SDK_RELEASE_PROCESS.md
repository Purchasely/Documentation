# Documentation process for a new SDK version

This file is the procedure to document a new minor or major version of the Purchasely SDK (for example 6.2.0). It covers the changelog, the new features, the deprecated APIs, the Console screenshots, the default version and the final checks.

Use this procedure for each new `X.Y.0` version. A patch version (`X.Y.Z`) usually needs only the changelog of the platform repositories.

---

## 0. Branches and publication

| Branch | Content | Published on |
| :-- | :-- | :-- |
| `vX.Y` | The documentation of version X.Y (`docs/`, `custom_blocks/`, `platform/`, …) | ReadMe version X.Y, `https://docs.purchasely.com/docs/<slug>` |
| `main` | The changelogs only (`changelogs/`) | `https://docs.purchasely.com/changelog` |

- ReadMe syncs each branch in both directions. A change in the ReadMe editor comes back as a commit `Updated "<page>" in docs`. Always `git pull` before you edit, and rebase before you push.
- Push the documentation directly to `vX.Y`. A pull request is not necessary.
- Only a human pushes to `main`. An agent pushes a branch (for example `changelog/X.Y`) and gives the push command to the human:
  `git push origin changelog/X.Y:main`
- The `vX.Y` branch is created from `vX.(Y-1)` when the version is created in ReadMe. Do the work on `vX.Y`, not on the previous version.

---

## 1. Collect the changes of the release

1. Read the public release notes. They are the reference for the changelog:
   ```bash
   gh release view X.Y.0 -R Purchasely/Purchasely-iOS
   gh release view X.Y.0 -R Purchasely/Purchasely-Android
   gh release list -R Purchasely/Purchasely-Flutter -L 1
   gh release list -R Purchasely/Purchasely-ReactNative -L 1
   gh release list -R Purchasely/Purchasely-Cordova -L 1
   ```
2. Read the SDK sources at the release tag to get the exact API names, signatures and behaviors. Do not copy an API name from memory.
   - iOS: `Purchasely-iOS-Sources`, tag `X.Y.0`, `Sources/Purchasely/common/Purchasely+PublicInterface.swift`, and `docs/features/`.
   - Android: `Purchasely-Android-Sources`, tag `X.Y.0`, `core/src/main/java/io/purchasely/ext/Purchasely.kt`.
   - Bridges: the release tag, or the feature branch when the bridge is not released yet (for example `git grep -i <feature> $(git for-each-ref --format='%(refname)' refs/remotes/origin)`).
3. Make a list of:
   - the new features, for each platform;
   - the new and the deprecated APIs;
   - the behavior changes and the source-compatibility changes;
   - the fixes.

---

## 2. Write the changelog (branch `main`)

1. Create the branch from `main`: `git switch -c changelog/X.Y origin/main`.
2. Copy the format of the previous changelog exactly: `changelogs/<previous>.md`. The file name is `changelogs/<XY>-<short-slug>.md` (for example `62-custom-events.md`).
3. Frontmatter: `title: X.Y - <Main feature>`, `author`, `hidden: false`, `metadata.robots: noindex`, `published_at` (release date, ISO 8601), `type: added`.
4. Sections, in this order:
   - Introduction (two short paragraphs) and **Highlights**.
   - **Version per platform** table. A bridge that is not released yet shows `Coming soon`.
   - **🚀 Features**: one `##` section for each feature, with `<Tabs>` for iOS and Android code, and a link `[Page](doc:<slug>)` to the documentation page.
   - **⚠️ Behavior Changes** (when there are any).
   - **🍎 iOS** and **🤖 Android**: Features & Improvements, Action Required, Fixes & Reliability.
5. Check each claim against the Console. Example: do not write that an attribute can target an audience when the audience editor does not list it.
6. Push the branch, and give the push command for `main` to a human (see section 0).

---

## 3. Document the new features (branch `vX.Y`)

1. Find the correct place in the sidebar. The order of the pages comes from `_order.yaml` in each folder. The slug of a page is its file name.
2. Before you choose a slug, look for links that the Console already uses:
   ```bash
   grep -rn "docs.purchasely.com/docs/" purchasely-console/components purchasely-console/app
   ```
   Use the slug that the Console expects.
3. Write the page in ASD-STE100 Simplified Technical English. Use the frontmatter format of `AGENTS.md`. Start with an **Availability** callout that gives the minimum SDK version and the platforms.
4. Document the Console side (configuration, screenshots) and the SDK side (code for Swift, Objective-C, Kotlin, Java, and the bridges when they are available).
5. Update the pages that the feature changes, for example:
   - `action-types.md` for a new Screen Composer action;
   - `campaign-configuration.md` for a new campaign trigger;
   - `privacy-settings.md` for a new data processing purpose (iOS, React Native, Flutter, Cordova and Android names);
   - the UI/SDK events list for new events.
6. Internal links use the slug: `[Custom Events](custom-events)` or `[Track event](action-types#track-event)`.

---

## 4. Document a deprecated API

When a method is deprecated and replaced:

1. Keep the old documentation. Move it under a title that ends with `(deprecated)`, and add a warning callout that names the new method.
2. Add a new section for the new method, before the old one, with an **Availability** callout (`SDK X.Y.0 and later`) and a complete code sample.
3. Link the two sections to each other with anchors (`#<title-in-kebab-case>`).
4. Update the short samples elsewhere on the page to the new method.
5. Check in the SDK source if the old method has a deprecation attribute (`@available(*, deprecated)` or `@Deprecated`). If it has none, tell the SDK team: developers get no warning in their IDE.

---

## 5. Take the Console screenshots

1. Use Playwright (MCP `plugin_playwright`). A human logs in to the Console and selects the client and the app (usually **Public App**).
2. Set a large viewport: `2560 × 1440`. Some Console fields are too narrow at smaller widths.
3. Use one example from start to end of the page (for example `ARTICLE_READ` and `ARTICLE_SHARED`). Ask the human before you create data in the app.
4. Do not save data that is not necessary:
   - campaigns: **Save as draft**, never **Start**;
   - Screen Composer: build a temporary Screen from **New screen**, and leave without **Save draft** or **Publish**;
   - experiments and audiences: **Cancel** at the end.
5. Crop each screenshot to the useful part (element screenshot or `clip`). Read each image before you keep it.
6. Save the images outside the repository: `/Users/<you>/Purchasely/tmp/<topic>/<N>-<name>.png`, numbered in the order of the page.
7. In the page, put each image as a commented placeholder:
   ```md
   <!-- TODO(screenshot): upload tmp/<topic>/<N>-<name>.png to ReadMe, then replace this comment with:
   <Image align="center" className="border" border={true} src="REPLACE_WITH_FILES_README_IO_URL" alt="<description>" />
   -->
   ```
8. Give the full path of each image to the human. The human uploads the images in the ReadMe editor at each placeholder. The ReadMe sync then commits the `files.readme.io` URLs.
9. Make a list of the Console problems that you find (layout bugs, wrong SDK badges, wrong text, internal-only menus). Give it to the Console team.
10. At the end, ask the human if you must delete the test data.

---

## 6. Set the new default SDK version (branch `vX.Y`)

Change the install version everywhere, but do not change the history.

**Change** (install or current version):
- `pod 'Purchasely', 'X.Y.0'`, SPM `from: "X.Y.0"`
- `implementation 'io.purchasely:<artifact>:X.Y.0'`
- `npm install react-native-purchasely@X.Y.0`, `package.json` entries
- `flutter pub add purchasely_flutter:X.Y.0`, `pubspec.yaml` entries
- `cordova plugin add @purchasely/cordova-plugin-purchasely@X.Y.0`
- "Pin each package to `X.Y.0`", the "Current version per platform" tables, "The latest version is X.Y.0"
- migration targets ("from v5.x to vX.Y.0"), the compiled `platform/*.md` files, the `compilation/` prompts, `AGENTS.md`, `llms.txt`

**Keep** (history or minimum version):
- "Requires SDK A.B.0", "available from vA.B.0", "From SDK A.B.0", "new in A.B.0", "Before A.B.0"
- `// SDK A.B.0` comments in code samples
- "Minimum SDK versions" lists, "SDK A.B+ required"
- descriptions of real sample projects or of a real past release

Procedure:
1. List all the mentions: `git -c core.quotePath=false grep -n "<previous version>"` (`core.quotePath=false` is necessary because the folder names contain emoji).
2. Replace with a script that skips the lines of the **Keep** list. Print the kept lines.
3. Read the full diff of the lines that are not install commands. Put back each line that describes the past.
4. Search also the short forms (`6.1`, `6.1+`, `v6.1`) and decide for each one.
5. Run `./compilation/compile_sdk_docs.sh check`.

---

## 7. Check the publication

Do these checks after each push (the ReadMe sync takes less than one minute):

1. Each new or changed page returns HTTP 200 and contains the new text:
   ```bash
   curl -sL https://docs.purchasely.com/docs/<slug> | grep -c "<text>"
   ```
2. Each anchor that you link to exists in the HTML (`id="<anchor>"`).
3. Each image URL returns HTTP 200, and no `TODO(screenshot)` is left.
4. The position of the page in the sidebar is correct (order of the `href="/docs/..."` links in the HTML).
5. The changelog is on `https://docs.purchasely.com/changelog/<file-name-without-.md>`.
6. Look at the diff of each ReadMe sync commit (`Updated "<page>" in docs`). A human can remove or change content in the editor. Keep these changes; do not revert them.

---

## 8. Communicate

Post a summary in the Slack thread of the release:
- each changed page, with its link (and the anchor of the section);
- the changelog link;
- the Console problems that you found;
- the test data that is still in the app.

---

## Checklist

- [ ] Release notes of iOS, Android and the bridges collected
- [ ] Changelog `changelogs/<XY>-<slug>.md` on `main` (pushed by a human)
- [ ] New feature pages on `vX.Y`, at the correct place in `_order.yaml`
- [ ] Pages changed by the features (actions, triggers, privacy, events)
- [ ] Deprecated APIs: old section kept and marked, new section added, links between them
- [ ] Console screenshots taken, uploaded to ReadMe by a human, no `TODO(screenshot)` left
- [ ] Default version `X.Y.0` on every platform, history unchanged
- [ ] `./compilation/compile_sdk_docs.sh check` passes
- [ ] Published pages, anchors, images and changelog checked
- [ ] Summary posted in Slack
- [ ] Test data deleted or kept, as the human decided
