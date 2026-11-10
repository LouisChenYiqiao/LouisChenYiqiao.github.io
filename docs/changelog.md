# Changelog

## 2026-11-10

### English content

- Translated all homepage copy, metadata, navigation, buttons, and accessibility labels into English.
- Set the document language to `en` and simplified the font stack.
- Translated source comments, deployment messages, and repository documentation.
- Renamed the maintenance guide and change history to `maintenance.md` and `changelog.md`, and updated their links.

### Privacy cleanup

- Kept the LouisQiao nickname, existing colors, and background photograph while removing personal identity, location, and biographical details.
- Replaced the contact section with Life & Creativity content and removed the personal email address and public contact file.
- Removed identifying references from current source files and documentation. The deployment helper now reads its remote address from local Git configuration.
- Gave the background photograph a descriptive filename and confirmed it has no EXIF or XMP metadata.
- Excluded local tool state from the public repository.

## 2026-09-13

### Review and improvements

- Verified the desktop homepage, navigation, section anchors, and the contact link available at that time.
- Refined the hero image overlays and position, and added a subtle navigation shadow after scrolling.
- Replaced the visual information list with semantic markup and improved keyboard focus and reduced-motion support.
- Tightened the Content Security Policy to same-origin resources and removed directives that cannot be reliably enforced through a meta element.
- Added a public security contact file at that time; it was later removed during the privacy cleanup. Kept `.nojekyll` for direct static publishing.
- Updated the deployment helper to pass its credential through a temporary `GIT_ASKPASS` script instead of a remote URL or process argument.
- Preserved the remote-ancestor check to prevent overwriting unsynchronized changes.

### Validation

- Passed `git diff --check` and `bash -n scripts/deploy.sh`.
- Reviewed the Content Security Policy and HTML/JavaScript resource paths.

## 2026-08-24

### Site recovery

The homepage had stopped loading and returned a 404. Its source files were intact, but GitHub Pages publishing was disabled.

- Backed up the original builder output locally.
- Removed legacy builder templates, libraries, and unused assets.
- Rebuilt the site with plain HTML and CSS and a responsive layout.
- Added the README, maintenance guide, ignore rules, and deployment helper.
- Enabled GitHub Pages publishing from the root of `main` and verified a successful response.

### Deployment maintenance

- Kept deployment credentials outside the repository and excluded credential file patterns from Git.
- Added the deployment helper to support the edit, commit, and push workflow.
- Kept the repository public for its existing publishing setup.

### Content and appearance

- Adopted the public nickname LouisQiao throughout the site.
- Removed the previous work section and simplified the About section.
- Reworked the colors around the warm sunset photograph and added the matching letter-based favicon.
- Simplified the contact section at that time; the contact section was later removed during the privacy cleanup.
