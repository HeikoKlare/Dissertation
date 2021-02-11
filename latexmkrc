# Run pdflatex with more memory because of several tikz figures
$pdflatex = 'pdflatex --extra-mem-top=10000000 -synctex=1 --interaction=nonstopmode -file-line-error %O %S';

# Generate pdf using pdflatex (-pdf)
$pdf_mode = 1;

# Glossaries, from https://ftp.rrze.uni-erlangen.de/ctan/support/latexmk/example_rcfiles/glossary_latexmkrc
add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";
sub makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    my $return = system "makeglossaries", $base_name;
    popd;
    return $return;
}

# Further cleanup
$clean_ext .= " bbl bcf blg fdb_latexmk fls ist loa loe lof log lol lot mw out run.xml synctex.gz xmpi"
