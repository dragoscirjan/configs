package utils

import "flag"

var Flags struct {
	ForceInstall        bool
	RefreshApps         bool
	PreferredInstallers string
	Browsers            string
	Fonts               string
	Git                 string
	Ide                 string
	Im                  string
	Language            string
	Office              string
	Rest                string
	Ssl                 string
	Vm                  string
	Vpn                 string
}

func ParseFlags() {

	flag.StringVar(&Flags.Browsers, "browser", "recommend", "install the mentioned browsers")

	flag.StringVar(&Flags.Fonts, "font", "recommend", "install the mentioned fonts")

	flag.StringVar(&Flags.Git, "git", "recommend", "install the mentioned git tools")

	flag.StringVar(&Flags.Ide, "ide", "recommend", "install the mentioned ides")

	flag.StringVar(&Flags.Language, "language", "recommend", "install the mentioned languages")

	flag.StringVar(&Flags.Office, "office", "recommend", "install the mentioned office tools")

	flag.StringVar(&Flags.Rest, "rest", "recommend", "install the mentioned rest tools")

	flag.StringVar(&Flags.Ssl, "ssl", "recommend", "install the mentioned ssl tools")

	flag.StringVar(&Flags.Vm, "vm", "recommend", "install the mentioned vm tools")

	flag.StringVar(&Flags.Vpn, "vpn", "recommend", "install the mentioned vpn tools")

	flag.BoolVar(&Flags.ForceInstall, "y", false, "force install (without confirmation)")
	flag.BoolVar(&Flags.RefreshApps, "refresh-apps", false, "refresh the app db before installing")
	flag.StringVar(&Flags.PreferredInstallers, "preferred-installers", "", "use the installers in this preferred order")

	flag.Parse()
}
