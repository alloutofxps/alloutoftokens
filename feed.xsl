<?xml version="1.0" encoding="UTF-8"?>
<!--
  Browsers stopped rendering RSS years ago, so feed.xml arrives as a wall of
  raw XML and the RSS link in the footer looks broken. This stylesheet is
  applied by the browser only; feed readers ignore it entirely and parse the
  XML underneath as usual. Self-contained on purpose: no external CSS, so it
  cannot be affected by anything in styles.css.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"
              doctype-system="about:legacy-compat" />

  <xsl:template match="/rss/channel">
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title><xsl:value-of select="title" /> — RSS feed</title>
        <meta name="robots" content="noindex" />
        <link rel="icon" href="favicon.svg" type="image/svg+xml" />
        <style>
          :root {
            --paper: #f4efe6; --surface: #faf7f1; --ink: #1b1714; --ink-2: #3b342e;
            --ink-3: #5f574e; --accent: #8a2d42; --rule: rgba(27,23,20,0.13);
            --ff-display: 'Newsreader', Georgia, 'Times New Roman', serif;
            --ff-sans: 'Inter', system-ui, -apple-system, sans-serif;
          }
          * { box-sizing: border-box; margin: 0; padding: 0; }
          body {
            background: var(--paper); color: var(--ink);
            font-family: var(--ff-sans); font-size: 17px; line-height: 1.6;
            -webkit-font-smoothing: antialiased;
          }
          .wrap { max-width: 720px; margin-inline: auto; padding: 64px 24px 96px; }
          .eyebrow {
            font-size: 13px; font-weight: 600; letter-spacing: 0.1em;
            text-transform: uppercase; color: var(--accent); margin-bottom: 16px;
          }
          h1 {
            font-family: var(--ff-display); font-weight: 600; line-height: 1.1;
            font-size: clamp(2rem, 6vw, 2.75rem); letter-spacing: -0.02em;
            margin-bottom: 16px;
          }
          .tagline { font-size: 19px; color: var(--ink-2); margin-bottom: 40px; }
          .explain {
            background: var(--surface); border-left: 2px solid var(--accent);
            padding: 24px; margin-bottom: 48px;
          }
          .explain p { color: var(--ink-2); font-size: 15px; }
          .explain p + p { margin-top: 12px; }
          .url {
            display: block; margin-top: 16px; padding: 12px 16px;
            background: var(--ink); color: #f7f3ec; word-break: break-all;
            font-family: ui-monospace, 'SF Mono', monospace; font-size: 13px;
          }
          h2 {
            font-family: var(--ff-display); font-size: 13px; font-weight: 600;
            letter-spacing: 0.1em; text-transform: uppercase; color: var(--ink-3);
            padding-bottom: 12px; border-bottom: 1px solid var(--rule);
            margin-bottom: 8px;
          }
          .item { padding: 24px 0; border-bottom: 1px solid var(--rule); }
          .item-meta {
            font-size: 13px; letter-spacing: 0.04em; color: var(--ink-3);
            margin-bottom: 8px;
          }
          .item-meta .cat { color: var(--accent); font-weight: 600; }
          .item h3 { font-family: var(--ff-display); font-size: 22px; font-weight: 600; line-height: 1.25; }
          .item h3 a { color: var(--ink); text-decoration: none; border-bottom: 1px solid transparent; }
          .item h3 a:hover { color: var(--accent); border-bottom-color: var(--accent); }
          .item p { color: var(--ink-2); font-size: 15px; margin-top: 8px; }
          .home { display: inline-block; margin-top: 40px; color: var(--ink-3); font-size: 15px; }
          .home:hover { color: var(--accent); }
          @media (prefers-color-scheme: dark) {
            :root { --paper: #17140f; --surface: #211c16; --ink: #f4efe6;
                    --ink-2: #cdc3b5; --ink-3: #9c9187; --accent: #d98da0;
                    --rule: rgba(244,239,230,0.16); }
            .url { background: #000; }
            .item h3 a { color: var(--ink); }
          }
        </style>
      </head>
      <body>
        <div class="wrap">
          <p class="eyebrow">RSS feed</p>
          <h1><xsl:value-of select="title" /></h1>
          <p class="tagline"><xsl:value-of select="description" /></p>

          <div class="explain">
            <p><strong>This page is a feed, not an article.</strong> It lets a reader app
               show you new posts here without you having to check the site or hand over
               an email address.</p>
            <p>To subscribe, copy this address into any feed reader — NetNewsWire,
               Feedly, Inoreader, Thunderbird, or whatever you already use:</p>
            <code class="url"><xsl:value-of select="/rss/channel/link" />feed.xml</code>
          </div>

          <h2><xsl:value-of select="count(item)" /> posts</h2>
          <xsl:for-each select="item">
            <div class="item">
              <p class="item-meta">
                <span class="cat"><xsl:value-of select="category" /></span>
                <xsl:text> · </xsl:text>
                <xsl:value-of select="substring(pubDate, 6, 11)" />
              </p>
              <h3><a href="{link}"><xsl:value-of select="title" /></a></h3>
              <p><xsl:value-of select="description" /></p>
            </div>
          </xsl:for-each>

          <a class="home" href="{/rss/channel/link}">← Back to alloutoftokens.com</a>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
