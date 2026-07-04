# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Stack

SAP CAP (Cloud Application Programming Model) project, Node.js flavor.

- `@sap/cds` (v9) — CAP core framework
- `@cap-js/hana` — HANA database service (production)
- `@cap-js/sqlite` — in-memory/file DB for local development
- `@sap/xssec` + `xsuaa` — authentication, required only in the `production` cds profile (see `package.json` cds config)
- Deployed as a Cloud Foundry MTA (`mta.yaml`): an `nodejs` service module (`SupplyFlow-srv`) plus an `hdb` deployer module (`SupplyFlow-db-deployer`), bound to `xsuaa` and `hana` (hdi-shared) resources.

## Project layout

Standard CAP layout — most of this doesn't exist yet, but future code should land here:

- `db/` — domain models (CDS entities) and native DB artifacts
- `srv/` — service definitions and custom service handlers (`.cds` + `.js`)
- `app/` — UI frontend(s)
- `xs-security.json` — XSUAA scopes/roles/attributes for auth
- `mta.yaml` — Cloud Foundry multi-target app deployment descriptor

The project is currently just scaffolded (no domain model or services written yet), so there isn't an established architecture to describe beyond the CAP conventions above.

## Commands

- `cds watch` — run the app locally with auto-reload (uses SQLite by default via devDependencies)
- `npm start` (`cds-serve`) — start the service without watch/reload
- `cds build --production` — build for deployment (what the MTA build step runs)
- `mbt build` — build the deployable `.mtar` (requires Cloud MTA Build Tool)
- No lint or test setup exists yet in this repo.
