#! @bash@

file="$1"
force=f

# Other simple options
case "$1" in
  --help)
    @echo@ 'Usage: mkEnv [OPTION] NAME'
    @echo@ ''
    @echo@ 'Quickly add template shell.nix files'
    @echo@ ''
    @echo@ 'OPTIONS'
    @echo@ '  -l, --list  List all available environments'
    @echo@ '  -f, --force Write shell.nix file even if one already exists'
    @echo@ ''
    @echo@ 'NAME'
    @echo@ '  Name of the environment to inject or querry when listing envs'
    exit 0
    ;;
  --list)
    if @test@ -z "$2"
    then
      @ls@ "@SHELLS@"
    else
      @ls@ "@SHELLS@" | @grep@ "$2"
    fi
    exit 0
    ;;
  -f)
    ;&
  --force)
    file="$2"
    force=t
    ;;
esac

filename="@SHELLS@/$file"

# Test if there is something we can insert first
if @test@ ! -f "$filename"
then
  >2& @echo@ "No default for this environment"
  exit 127
fi

# Then make sure we're not overwriting a file unintentionally
if @test@ -e shell.nix -a $force = f
then
  >2& @echo@ "Would be overwriting an existing file use -f to allow this"
  exit 1
fi

# Then insert the file
@cp@ "$filename" shell.nix
@chmod@ 644 shell.nix
