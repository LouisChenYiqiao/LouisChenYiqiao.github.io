# LouisQiao - Personal Homepage

A personal homepage built with HTML, CSS, and JavaScript, published through GitHub Pages.

The site shares a nickname, interests, and creative notes without publishing personal contact details. The current publishing address is available under **Settings > Pages** in this repository.

## Project structure

```text
index.html                     Homepage and navigation
assets/css/style.css           Site styles
assets/js/site.js              Small interface enhancements
assets/images/sunset-walk.jpeg  Background photograph
assets/images/favicon.svg      Site icon
docs/maintenance.md            Maintenance guide
docs/changelog.md              Change history
scripts/deploy.sh              Deployment helper
```

## Technology

- Plain HTML, CSS, and JavaScript, with no framework or build dependencies.
- Responsive layouts for desktop and mobile screens.
- GitHub Pages publishing from the root of the `main` branch.

## Local preview

Run this command from the repository root:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Open <http://127.0.0.1:8000> in a browser.

## Updating the site

1. Edit `index.html` or the files under `assets/`.
2. Review the changes, commit them, and push to `main`:

```bash
git add -A
git commit -m "Update homepage content"
git push origin main
```

3. Wait for GitHub Pages to finish publishing and check the live site.

See the [maintenance guide](docs/maintenance.md) for deployment and troubleshooting details.

## Privacy and security

Keep published text, comments, and filenames in English. Do not add personal contact details or identifying account information to the site or its documentation. The Content Security Policy limits resources to the same origin, and deployment credentials stay outside the repository.
