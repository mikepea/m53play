package cmd

import (
        "github.com/spf13/cobra"
        "github.com/mikepea/m53play/frontweb"
)

// versionCmd represents the version command
var frontwebCmd = &cobra.Command{
        Use:   "frontweb",
        Short: "Playground frontend webserver",
        Long:  `Playground frontend webserver`,
        Run: func(cmd *cobra.Command, args []string) {
          frontweb.StartServer()
        },
}

func init() {
        rootCmd.AddCommand(frontwebCmd)
}
