---
layout: page
permalink: /cv/
title: cv
nav: true
nav_order: 4
cv_pdf: Narasimha_Karthik_Resume.pdf # you can also use external links here
description: My comprehensive curriculum vitae highlighting my experience in AI/ML, research work, and technical achievements.
---

<div class="text-center mb-4">
  <a href="{{ 'assets/pdf/' | append: page.cv_pdf | relative_url }}" class="btn btn-primary btn-lg" target="_blank">
    <i class="fa-solid fa-download"></i> Download PDF
  </a>
  <a href="{{ 'assets/pdf/' | append: page.cv_pdf | relative_url }}" class="btn btn-outline-secondary btn-lg ml-2" target="_blank">
    <i class="fa-solid fa-external-link"></i> Open in New Tab
  </a>
</div>

<div class="cv-container" style="width: 100%; height: 800px; border: 1px solid #ddd; border-radius: 8px; overflow: hidden;">
  <iframe 
    src="{{ 'assets/pdf/' | append: page.cv_pdf | relative_url }}" 
    width="100%" 
    height="100%" 
    style="border: none;"
    title="CV PDF">
    <p>Your browser does not support PDFs. 
    <a href="{{ 'assets/pdf/' | append: page.cv_pdf | relative_url }}" target="_blank">Download the PDF</a> instead.</p>
  </iframe>
</div>

<div class="text-center mt-3">
  <small class="text-muted">
    <i class="fa-solid fa-info-circle"></i> 
    Having trouble viewing? <a href="{{ 'assets/pdf/' | append: page.cv_pdf | relative_url }}" target="_blank">Click here to open in a new tab</a>
  </small>
</div>
