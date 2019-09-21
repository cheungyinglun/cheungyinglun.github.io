---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---

{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

## Research Interests

<ul>High-dimensional factor models, Time series analysis, Empirical asset pricing</ul>

## Working Papers

<ul>{% for post in site.workingpapers reversed %}
  {% include archive-single-cv.html %}
{% endfor %}</ul>
