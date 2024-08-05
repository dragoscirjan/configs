package utils

import "flag"

var Flags struct {
	ForceInstall        bool
	RefreshApps         bool
	PreferredInstallers string
	Browsers            bool
	BrowserList         string
	Fonts               bool
	FontList            string
	Git                 bool
	GitList             string
	Ide                 bool
	IdeList             string
	Im                  bool
	ImList              string
	Language            bool
	LanguageList        string
	Office              bool
	OfficeList          string
	Rest                bool
	RestList            string
	Ssl                 bool
	SslList             string
	Vm                  bool
	VmList              string
	Vpn                 bool
	VpnList             string
}

func ParseFlags() {

	flag.BoolVar(&Flags.Browsers, "browsers", false, "install all browsers")
	flag.StringVar(&Flags.BrowserList, "browser-list", "", "install the mentioned browsers")

	flag.BoolVar(&Flags.Fonts, "fonts", false, "install all fonts")
	flag.StringVar(&Flags.FontList, "font-list", "", "install the mentioned fonts")

	flag.BoolVar(&Flags.Git, "git", false, "install all git tools")
	flag.StringVar(&Flags.GitList, "git-list", "", "install the mentioned git tools")

	flag.BoolVar(&Flags.Ide, "ides", false, "install all ides")
	flag.StringVar(&Flags.IdeList, "ide-list", "", "install the mentioned ides")

	flag.BoolVar(&Flags.Language, "languages", false, "install all languages")
	flag.StringVar(&Flags.LanguageList, "language-list", "", "install the mentioned languages")

	flag.BoolVar(&Flags.Office, "office", false, "install all office tools")
	flag.StringVar(&Flags.OfficeList, "office-list", "", "install the mentioned office tools")

	flag.BoolVar(&Flags.Rest, "rest", false, "install all rest tools")
	flag.StringVar(&Flags.RestList, "rest-list", "", "install the mentioned rest tools")

	flag.BoolVar(&Flags.Ssl, "ssl", false, "install all ssl tools")
	flag.StringVar(&Flags.SslList, "ssl-list", "", "install the mentioned ssl tools")

	flag.BoolVar(&Flags.Vm, "vm", false, "install all vm tools")
	flag.StringVar(&Flags.VmList, "vm-list", "", "install the mentioned vm tools")

	flag.BoolVar(&Flags.Vpn, "vpn", false, "install all vpn tools")
	flag.StringVar(&Flags.VpnList, "vpn-list", "", "install the mentioned vpn tools")

	flag.BoolVar(&Flags.ForceInstall, "y", false, "force install (without confirmation)")
	flag.BoolVar(&Flags.RefreshApps, "refresh-apps", false, "refresh the app db before installing")
	flag.StringVar(&Flags.PreferredInstallers, "preferred-installers", "", "use the installers in this preferred order")

	flag.Parse()
}
