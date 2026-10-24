package main

import (
	"bytes"
	"errors"
	"runtime/debug"
	"strings"
	"testing"
)

func TestRun(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name       string
		args       []string
		wantStdout string
		wantStderr string
		wantErr    error
	}{
		{name: "greeting", args: nil, wantStdout: "Less setup, more Go! 🚀\n"},
		{name: "version", args: []string{"-version"}, wantStdout: "dev\n"},
		{name: "help", args: []string{"-h"}, wantStderr: "Usage of go-kickstart"},
		{name: "unknown flag", args: []string{"-nope"}, wantStderr: "Usage of go-kickstart", wantErr: errUsage},
		{name: "extra argument", args: []string{"extra"}, wantStderr: "unexpected argument: extra", wantErr: errUsage},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			var stdout, stderr bytes.Buffer

			err := run(tt.args, &stdout, &stderr)
			if !errors.Is(err, tt.wantErr) {
				t.Fatalf("run(%q) error = %v, want %v", tt.args, err, tt.wantErr)
			}

			if got := stdout.String(); got != tt.wantStdout {
				t.Errorf("run(%q) stdout = %q, want %q", tt.args, got, tt.wantStdout)
			}

			gotStderr := stderr.String()
			if tt.wantStderr == "" && gotStderr != "" {
				t.Errorf("run(%q) stderr = %q, want it empty", tt.args, gotStderr)
			}

			if !strings.Contains(gotStderr, tt.wantStderr) {
				t.Errorf("run(%q) stderr = %q, want it to contain %q", tt.args, gotStderr, tt.wantStderr)
			}
		})
	}
}

func TestExitCode(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name       string
		err        error
		want       int
		wantStderr string
	}{
		{name: "success", err: nil, want: 0},
		{name: "usage", err: errUsage, want: 2},
		{name: "wrapped usage", err: errors.Join(errUsage, errors.New("bad flag")), want: 2},
		{name: "failure", err: errors.New("boom"), want: 1, wantStderr: "go-kickstart: boom\n"},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			var stderr bytes.Buffer

			if got := exitCode(tt.err, &stderr); got != tt.want {
				t.Errorf("exitCode(%v) = %d, want %d", tt.err, got, tt.want)
			}

			if got := stderr.String(); got != tt.wantStderr {
				t.Errorf("exitCode(%v) stderr = %q, want %q", tt.err, got, tt.wantStderr)
			}
		})
	}
}

func TestResolveVersion(t *testing.T) {
	t.Parallel()

	withVersion := func(v string) *debug.BuildInfo {
		return &debug.BuildInfo{Main: debug.Module{Version: v}}
	}

	tests := []struct {
		name   string
		linked string
		info   *debug.BuildInfo
		want   string
	}{
		{name: "goreleaser version wins", linked: "1.2.3", info: withVersion("v9.9.9"), want: "1.2.3"},
		{name: "go install version", linked: "dev", info: withVersion("v1.4.0"), want: "v1.4.0"},
		{name: "local build", linked: "dev", info: withVersion("(devel)"), want: "dev"},
		{name: "empty module version", linked: "dev", info: withVersion(""), want: "dev"},
		{name: "no build info", linked: "dev", info: nil, want: "dev"},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			if got := resolveVersion(tt.linked, tt.info); got != tt.want {
				t.Errorf("resolveVersion(%q, %v) = %q, want %q", tt.linked, tt.info, got, tt.want)
			}
		})
	}
}
