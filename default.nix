{ stdenv, bash, coreutils, gnugrep }:

stdenv.mkDerivation {
  name = "mkEnv";

  buildCommand = ''
    mkdir -p $out/bin $out/shells
    for filepath in ${./shells}/*.nix
    do
      file=$(basename -- "$filepath")
      cp "$filepath" "$out/shells/''${file%.nix}"
    done

    install -v -D -m755 ${./mkEnv.sh} $out/bin/mkEnv
    substituteInPlace $out/bin/mkEnv \
      --subst-var-by bash "${bash}/bin/bash" \
      --subst-var-by chmod "${coreutils}/bin/chmod" \
      --subst-var-by cp "${coreutils}/bin/cp" \
      --subst-var-by echo "${coreutils}/bin/echo" \
      --subst-var-by grep "${gnugrep}/bin/grep" \
      --subst-var-by ls "${coreutils}/bin/ls" \
      --subst-var-by test "${coreutils}/bin/test" \
      --subst-var-by SHELLS "$out/shells"
  '';

  meta = with stdenv.lib; {
    description = "Quickly add template shell.nix files";
    platforms = platforms.unix;
    license = licenses.unlicense;
  };
}
