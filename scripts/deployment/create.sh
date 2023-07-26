#!/bin/sh

mkdir dist && zip dist/bundle.zip -r . -x \
.\* \
node_modules/\* \
coverage/\* \
scripts/\* \
mocks/\* \
dist/\* \
src/\* \
npm-debug.log \
package\*.json \
\*.md \
\*/\*.test.jsx \
\*/\*.test.js \