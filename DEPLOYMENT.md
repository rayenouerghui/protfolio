# Portfolio Deployment Guide

## 🚀 Netlify Deployment

### Option 1: Drag & Drop (Easiest)
1. Run the build command:
   ```bash
   npm run deploy
   ```
2. Drag the `out` folder to Netlify's deploy area
3. Your site will be live!

### Option 2: Git Integration
1. Push your code to GitHub
2. Connect your GitHub repo to Netlify
3. Set build settings:
   - Build command: `npm run build && npm run export`
   - Publish directory: `out`
   - Node version: `18`

## 🌐 InfinityFree Deployment

### Steps:
1. Run the build command:
   ```bash
   npm run deploy
   ```
2. Upload the contents of the `out` folder to your `htdocs` directory
3. Ensure all files are uploaded including:
   - `index.html`
   - `_next/` folder
   - `images/` folder
   - All other static assets

## 📁 Build Output
- The `out` folder contains all static files
- No server required - pure static site
- All images are optimized and unoptimized for compatibility

## 🔧 Configuration Files
- `netlify.toml` - Netlify configuration
- `next.config.mjs` - Next.js build configuration
- `package.json` - Build scripts

## ✅ Pre-deployment Checklist
- [x] Favicon updated to Rockstar Games logo
- [x] Social links working (LinkedIn, GitHub)
- [x] Certification credentials working
- [x] All project links functional
- [x] Responsive design tested
- [x] Dark/light mode working
- [x] Static export configured

## 🎯 Live URLs
After deployment, your portfolio will be accessible at:
- Netlify: `https://your-site-name.netlify.app`
- InfinityFree: `https://your-domain.infinityfreeapp.com`

## 🛠️ Troubleshooting
- If images don't load, check the `public/images/` folder
- If styles are missing, ensure `_next/static/` folder is uploaded
- For routing issues, check the redirect configuration in `netlify.toml`