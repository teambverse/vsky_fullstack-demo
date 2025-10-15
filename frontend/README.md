
# Top Restaurants (React)
<p align="center">
  <img src="https://bcoder24.s3-accelerate.amazonaws.com/piya/1760519694128~Screenshot2.png" alt="App Preview 2" width="320" style="margin-right:10px;" />
  <img src="https://bcoder24.s3-accelerate.amazonaws.com/piya/1760519694130~Screenshot3.png" alt="App Preview 3" width="320" />
</p>
This is a small React frontend that lists restaurants and lets users add a new restaurant via a modal form. It was scaffolded with Create React App and uses Axios for HTTP requests and react-hot-toast for transient UI feedback.

This README explains how to run the project locally, the environment variables it expects, the project structure, and the important components.

## Quick start

Open a PowerShell terminal and run:

```powershell
cd e:\to_your_path\frontend
npm install
npm start
```

Then open http://localhost:3000 in your browser.

## Environment variables

The app reads the API base URL and API version from environment variables when calling the backend. Create a `.env` file in the project root (next to `package.json`) with values like:

```
REACT_APP_API_URL=http://localhost:8000
REACT_APP_API_VERSION=/api/v1
```

Notes:
- `REACT_APP_API_URL` should include protocol and host (for example `https://api.example.com`).
- `REACT_APP_API_VERSION` is concatenated directly to the URL in code, so include leading slash (for example `/v1` or `/api/v1`).

If these variables are not set, the app will still run but API calls may fail; the UI contains local fallbacks for create operations.

## Available scripts

Available npm scripts (from `package.json`):

- `npm start` — run the dev server
- `npm run build` — build the production bundle
- `npm test` — run tests (Create React App default)
- `npm run eject` — eject CRA configuration (one-way)

## Project structure

Top-level files/folders:

- `public/` — static files and `index.html`
- `src/` — application source
	- `App.js` — main app component; fetches restaurants and renders the list
	- `index.js` — React entry point
	- `index.css` — global styles used by the app
	- `components/`
		- `AddRestaurantModal.jsx` — modal form to add a restaurant (validation, live preview, POST to API)
	- `utils/`
		- `CountryCodePicker.jsx` — wrapper around `react-phone-input-2` used for phone input

## Important components

- AddRestaurantModal (`src/components/AddRestaurantModal.jsx`)
	- Controlled form that collects name, address, phone number and rating.
	- Client-side validation: required fields, rating between 1 and 5, phone length check.
	- Sends POST to `${REACT_APP_API_URL}${REACT_APP_API_VERSION}/restaurants` using Axios.
	- On successful creation it calls the `onCreate` callback passed from `App` and shows toast feedback.

- CountryCodePicker (`src/utils/CountryCodePicker.jsx`)
	- Uses `react-phone-input-2` for country-aware phone input.
	- Integrates with `next-themes` (optional) to support dark/light input styling.

- App (`src/App.js`)
	- Fetches restaurants at startup from the same `/restaurants` endpoint and renders a list.
	- Opens `AddRestaurantModal` to add a restaurant; local state is updated when a restaurant is added.

## Notable dependencies

- `react` / `react-dom` — UI library
- `axios` — HTTP client used for API calls
- `react-hot-toast` — toast notifications
- `react-phone-input-2` — phone input with country picker
- `next-themes` — optional theme detection used by phone input

Full dependency list is in `package.json`.

## Development notes & troubleshooting

- If API requests fail during development, check the `.env` variables and CORS settings on your backend.
- The app assumes the backend returns a JSON shape like `{ isSuccess: boolean, items?: [...], ... }` for GET and a similar `{ isSuccess: boolean, ... }` for POST. Adjust `App.js` and `AddRestaurantModal.jsx` if your API differs.
- Styling is minimal and lives in `src/index.css`; feel free to replace with a CSS framework or CSS-in-JS solution.

## Contributing

Open an issue or submit a PR with small, focused changes. Keep components small and test behavior for form validation and API interaction.

## License

This repository does not include a license file. Add one if you plan to open-source the project.
