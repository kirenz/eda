// Cration of single PDF documents using Puppeteer

"use strict";

const path = require("path");
const puppeteer = require("puppeteer");
let my_slide = 'slides.html';

(async () => {
  const htmlFile = path.resolve("./" + my_slide);
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto("file://" + htmlFile);
  await page.pdf({ path: "./" + my_slide + ".pdf", format: 'a4', landscape: true });
  await browser.close();
})();