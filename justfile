_default:
    just --list
    
# publish package to PPM
publish:
  rspm add --source=internally_published --path=/usr/home/david/urbanindex_0.1.0.tar.gz