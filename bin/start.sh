#!/bin/sh

bin/elixir_ic eval "ElixirIc.ReleaseTasks.migrate()"

bin/elixir_ic start
