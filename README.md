## Project Overview

This repository is intended for the comparison (using sentiment analysis and topic modeling) of the iPhone X and Samsung Galaxy S8 using Twitter data.

- Which phone has the most positive response?
- What are some of the most talked about things about each phone?

## Key Concepts

- Data Collection
- Sentiment Analysis
- Topic Modeling (LDA)

## Topic Modeling


<iframe src="https://gist.github.com/ahipolito94/a52686c4ca42909a43a1dbac744689aa.js"></iframe>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>LDAvis</title>
    <script src="d3.v3.js"></script>
    <script src="ldavis.js"></script>
    <link rel="stylesheet" type="text/css" href="lda.css">
  </head>

  <body>
    <div id = "lda"></div>
    <script>
      var vis = new LDAvis("#lda", "lda.json");
    </script>
  </body>

</html>
