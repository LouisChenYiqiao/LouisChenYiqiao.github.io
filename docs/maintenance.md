# Maintenance Guide

## Site structure

The site uses plain HTML, CSS, and JavaScript with no framework or build dependencies. GitHub Pages publishes the root of the `main` branch. Find the publishing address under **Settings > Pages** in the repository.

```text
index.html
assets/css/style.css
assets/js/site.js
assets/images/sunset-walk.jpeg
assets/images/favicon.svg
scripts/deploy.sh
docs/maintenance.md
docs/changelog.md
```

The homepage contains a hero, an About section, and a Life & Creativity section. Their anchors are `top`, `about`, and `notes`. Navigation links and buttons should point to existing anchors.

## Editing content

- Edit copy in `index.html`. Keep the public nickname LouisQiao.
- Keep all published copy, accessibility labels, comments, documentation, and filenames in English. The document language is `en`.
- Edit styles in `assets/css/style.css`. The `.hero-bg` rule references the background photograph.
- Maintain small interface enhancements in `assets/js/site.js`, including the footer year and the navigation's scroll effect.
- Before adding an image, check for EXIF, GPS, author, and device metadata. Use a descriptive filename.
- The current site has no contact section or public `security.txt` containing a personal address.

## Local preview

Run this command from the repository root:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Open `http://127.0.0.1:8000` and check layout, navigation, and resource loading at desktop and mobile widths.

## Publishing

Commit the intended changes and push `main` to the configured `origin`. After GitHub Pages finishes publishing, verify the public page and its static resources.

Alternatively, use the existing deployment helper:

```bash
./scripts/deploy.sh "Update homepage content"
```

The helper reads the deployment credential from `secrets/github.token` in the repository's parent directory and passes it to Git through a temporary `GIT_ASKPASS` script. Never put credentials in source files, remote URLs, command arguments, or logs.

The helper checks whether remote `main` contains commits missing locally. If that check fails, reconcile the changes before deploying. Do not force-push over remote changes.

## Privacy and security

- Review HTML, comments, styles, scripts, image metadata, documentation, and other downloadable files before publishing.
- Do not add legal names, personal contact details, school or location information, local absolute paths, or identifying account addresses to published files.
- Repository history, account profiles, and search caches require separate review; changing current files does not erase those records.
- The Content Security Policy allows only same-origin scripts, styles, and images. Review it before introducing external resources.
- A Referrer Policy is set. The site does not embed external analytics, forms, or administration links.
- Keep local tool state and credentials in `.gitignore` so the deployment helper cannot stage them.

## Troubleshooting

- **404:** Check that **Settings > Pages** uses `main` and the repository root, and confirm that `index.html` exists.
- **Changes are missing:** Confirm the commit was pushed, inspect the Pages build result, and check again in a private browser window after publishing completes.
- **An image is missing:** Check that the file was committed and that its path, filename, and letter case match the reference.

See the [changelog](changelog.md) for a summary of previous updates.
