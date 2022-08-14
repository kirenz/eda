// Creation of multiple PDF documents using Puppeteer
// Execute script with    node create-all-pdfs.js

"use strict";

const path = require("path");
const puppeteer = require("puppeteer");
const my_slide = [
  '01-1-stents.slides.html',
  '01-3-passwords.slides.html',
  '04-1-contingency-table-bar-plot.slides.html',
  '04-2-two-categorical-variables.slides.html',
  '04-3-row-column-proportions.slides.html',
  '04-4-pie-charts.slides.html',
  '04-5-waffle-charts.slides.html',
  '04-6-comparisons-across-groups.slides.html',
  '05-1-scatterplot-paired-data.slides.html',
  '05-2-dot-plots-mean.slides.html',
  '05-3-histograms.slides.html',
  '05-3-x-case-height.slides.html',
  '05-5-box-plot.slides.html',
  '05-6-robust-statistics.slides.html',
  '05-7-transforming-data.slides.html',
  '05-8-mapping-data.slides.html',
  '10a-application-model-exploration.slides.html',
  '10b1-application-model-statsmodel.slides.html',
  '10b2-application-model-sklearn.slides.html',
  '10b3-application-model-tensorflow.slides.html'
   ];

(async () =>  {
  for (let i = 0; i < my_slide.length; i++){
    const htmlFile = path.resolve("./" + my_slide[i]);
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto("file://" + htmlFile);
    await page.pdf({ path: "./" + my_slide[i] + ".pdf", format: 'a4', landscape: true });
    await browser.close();
  }
})();