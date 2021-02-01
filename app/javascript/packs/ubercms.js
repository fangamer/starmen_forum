// note: this file imports from app/assets/stylesheets/ubercms.scss
// with webpacker 5, this does a whole hell of a lot of magic
// if you include a style sheet file, it knows and will do a bunch of stuff
//
// notably, see webpacker.yml
// extract_css is false on development and true on production
// for production, that means it will just make a css file if and only if you run `webpacker:compile`.
// (and also the older `assets:precompile` command since I removed the older sprockets system)
//
// however in development, the css is INCLUDED in the javascript files.
// why would you do this terrible thing?
// because of a fun command: `bin/webpack-dev-server`
// webpack-dev-server does two things:
// 1. builds as soon as you save, making things just that much quicker
// 2. but here's the fun magic, if you set `hmr:true` in webpacker.yml, it will LIVE RELOAD the css
// thats right, you do not have to reload the css file, it will just do it for you!
//
// there is a small catch and that's sometimes things get wonky so you may need to delete everything in public/packs
// (it's safe since it's not even a checked in file, it's just a cache for your js/css)
// webpack-dev-server as far as I can tell is just magic. Run it, and Rails automatically moves to live reloading.
// don't run it, rails will just fallback to a compile-on-each-change when the browser requests js/css
// it's like magic when it works!
//
// sadly it's terrible hell when it doesn't, heh.
//
// example gotcha: this file is not meant to be modified as it will cause a force reload
// so we just import
import 'stylesheets/ubercms';
import 'bootstrap'
