{ fetchurl, stdenv, texLive, python, makeWrapper, pkgconfig
, libX11, qt4, enchant #, mythes, boost
}:

stdenv.mkDerivation rec {
  version = "2.0.8.1";
  name = "lyx-${version}";

  src = fetchurl {
    url = "ftp://ftp.lyx.org/pub/lyx/stable/2.0.x/${name}.tar.xz";
    sha256 = "0n9wjzf5qqqmlki87giz7f2yxhjz3r53r6sfs890skjmf1h9q2ps";
  };

  configureFlags = [
    #"--without-included-boost"
    /*  Boost is a huge dependency from which 1.4 MB of libs would be used.
        Using internal boost stuff only increases executable by around 0.2 MB. */
    #"--without-included-mythes" # such a small library isn't worth a separate package
  ];

  buildInputs = [
    texLive qt4 python makeWrapper pkgconfig
    enchant # mythes boost
  ];

  doCheck = true;

  meta = {
    description = "WYSIWYM frontend for LaTeX, DocBook";
    homepage = "http://www.lyx.org";
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.vcunat ];
    platforms = stdenv.lib.platforms.linux;
  };
}
