# MattTunstall.com — GitHub Pages domain connection

Updated October 28, 2026. **The owner reports purchasing `MattTunstall.com` from IONOS.** The GitHub Pages connection, DNS ownership proof, TLS certificate and public availability **are not yet verified**. This repository's current publishing URL is `https://clearmyrecord.github.io/matthew-tunstall-website/`.

This is a **staged cutover** to avoid redirecting the existing GitHub Pages site to a domain before its DNS works. Do not commit a `CNAME` or change canonical URLs prematurely.

## 1. GitHub domain ownership verification

- Log into the **clearmyrecord** GitHub account and visit https://github.com/settings/pages
- Under **Verified domains**, add `matttunstall.com` (if the account presents this control). GitHub will show a unique TXT name and value. **Never guess or publish a placeholder challenge.**
- In IONOS → Domains & SSL → `matttunstall.com` → DNS, add the exact TXT challenge from GitHub.
- Confirm ownership in GitHub after DNS propagation. This verification is security-critical and independent of the later custom domain setting.

## 2. Assign the domain to this exact repository

Visit https://github.com/clearmyrecord/matthew-tunstall-website/settings/pages . Confirm publishing from the correct branch/folder and set **Custom domain** to `matttunstall.com`. GitHub Pages may create a root-level `CNAME` if publishing from a branch. Make sure only the **personal website** repository claims this host. Do not set the Memory Studio domain here.

## 3. Enter the GitHub Pages DNS records in IONOS

Manage only the DNS zone for `matttunstall.com`. Under DNS add these `A` records at the apex, host `@` (or blank if IONOS uses blank for root):

| Type | Host | Value |
| --- | --- | --- |
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | clearmyrecord.github.io |

If IONOS shows conflicting parked/default A/AAAA/www records, reconcile only those conflicting **web** records; do not delete unrelated MX/SPF/DKIM/TXT DNS records or IONOS email services. GitHub also supports optional IPv6 AAAA records, or ALIAS/ANAME where available. Do not use wildcard DNS.

## 4. Verify HTTPS before SEO cutover

- Test `https://matttunstall.com/` and `https://www.matttunstall.com/` in a browser; confirm the latter redirects to the preferred root and both have valid TLS.
- Enable **Enforce HTTPS** in the repository Pages settings once available.
- Only after verified: replace canonical, Open Graph and Person JSON-LD URLs across `index.html`, `about.html`, `ventures.html` and any other pages from `https://clearmyrecord.github.io/matthew-tunstall-website/` to `https://matttunstall.com/`; audit old absolute links carefully, and update `sitemap.xml` and `robots.txt` at the root. Test media paths and internal navigation.
- Verify the `matttunstall.com` domain property in Google Search Console using its own TXT record, submit `https://matttunstall.com/sitemap.xml` and review indexing. Search indexing and redirects can take time.
- After `memorystudio.tv` is also live, update cross-site links and promotional references to point to its new canonical domain.

## Notes

- `MemoryStudio.tv` is the **separate** domain for `clearmyrecord/memory-studio-website`; do not mix CNAME assignments or sitemaps.
- Stripe and RecordPathAI business verification are separate projects and **must not** have their business URLs automatically changed just because these domains were purchased.
- An email mailbox at `@matttunstall.com` is not automatically created by domain registration; manage any email product separately if desired.

Official guidance:
- https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
- https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages
- https://www.ionos.com/help/domains/dns-settings/
