// Command go-kickstart is the starting point for a new Go command.
package main

import (
	"errors"
	"flag"
	"fmt"
	"io"
	"os"
	"runtime/debug"
)

// version is set by goreleaser through -ldflags.
var version = "dev"

// errUsage marks usage errors that run has already reported.
var errUsage = errors.New("usage")

// 2 matches the exit status of the flag package for usage errors.
const (
	exitFailure = 1
	exitUsage   = 2
)

func main() {
	err := run(os.Args[1:], os.Stdout, os.Stderr)
	os.Exit(exitCode(err, os.Stderr))
}

func run(args []string, stdout, stderr io.Writer) error {
	fs := flag.NewFlagSet("go-kickstart", flag.ContinueOnError)
	fs.SetOutput(stderr)
	showVersion := fs.Bool("version", false, "print the version and exit")

	err := fs.Parse(args)
	if errors.Is(err, flag.ErrHelp) {
		return nil
	}

	if err != nil {
		return fmt.Errorf("%w: %w", errUsage, err)
	}

	if fs.NArg() > 0 {
		// A failed diagnostic write does not change the usage exit status.
		_, _ = fmt.Fprintf(stderr, "unexpected argument: %s\n", fs.Arg(0))
		fs.Usage()

		return errUsage
	}

	if *showVersion {
		_, err = fmt.Fprintln(stdout, buildVersion())
		if err != nil {
			return fmt.Errorf("write version: %w", err)
		}

		return nil
	}

	_, err = fmt.Fprintln(stdout, "Less setup, more Go! 🚀")
	if err != nil {
		return fmt.Errorf("write greeting: %w", err)
	}

	return nil
}

// exitCode also prints err, unless run has already reported it.
func exitCode(err error, stderr io.Writer) int {
	if err == nil {
		return 0
	}

	if errors.Is(err, errUsage) {
		return exitUsage
	}

	// A failed diagnostic write does not change the failure exit status.
	_, _ = fmt.Fprintf(stderr, "go-kickstart: %v\n", err)

	return exitFailure
}

func buildVersion() string {
	info, _ := debug.ReadBuildInfo()

	return resolveVersion(version, info)
}

// resolveVersion falls back to the module version that go install records.
func resolveVersion(linked string, info *debug.BuildInfo) string {
	if linked != "dev" || info == nil {
		return linked
	}

	if info.Main.Version == "" || info.Main.Version == "(devel)" {
		return linked
	}

	return info.Main.Version
}
