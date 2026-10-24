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

// errUsage marks errors that the flag package has already printed.
var errUsage = errors.New("usage")

func main() {
	err := run(os.Args[1:], os.Stdout, os.Stderr)
	if errors.Is(err, errUsage) {
		os.Exit(2)
	}

	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

// run holds the program logic, so tests can call it.
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

	if *showVersion {
		_, err = fmt.Fprintln(stdout, buildVersion())

		return err
	}

	_, err = fmt.Fprintln(stdout, "Less setup, more Go! 🚀")

	return err
}

// buildVersion falls back to the module version that go install records.
func buildVersion() string {
	if version != "dev" {
		return version
	}

	info, ok := debug.ReadBuildInfo()
	if !ok || info.Main.Version == "" || info.Main.Version == "(devel)" {
		return version
	}

	return info.Main.Version
}
