package main

import (
	"bytes"
	"errors"
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
		{name: "version", args: []string{"-version"}, wantStdout: buildVersion() + "\n"},
		{name: "help", args: []string{"-h"}, wantStderr: "Usage of go-kickstart"},
		{name: "unknown flag", args: []string{"-nope"}, wantStderr: "Usage of go-kickstart", wantErr: errUsage},
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

			if got := stderr.String(); !strings.Contains(got, tt.wantStderr) {
				t.Errorf("run(%q) stderr = %q, want it to contain %q", tt.args, got, tt.wantStderr)
			}
		})
	}
}
