// Cration of multiple PDF documents using Puppeteer

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
  '04-6-comparisons-across-groups.slides.html'
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