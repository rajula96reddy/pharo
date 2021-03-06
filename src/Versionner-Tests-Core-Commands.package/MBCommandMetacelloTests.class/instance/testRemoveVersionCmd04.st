tests
testRemoveVersionCmd04
	"Remove a bleedingEdge version with no imports"

	| configName class configurationRoot configInfo versionInfo cmd versionString |
	configName := 'ConfigurationOfMBFooIssue117'.
	self tearDownPackages addAll: {configName}.
	gofer version: 'ConfigurationOfMBFooIssue117-dkh.3'.
	gofer load.
	class := Smalltalk at: configName asSymbol.
	versionString := (class project version: #bleedingEdge) versionString.
	self assert: versionString = '2.0-baseline'.
	configurationRoot := MBConfigurationRoot new.
	configurationRoot register.
	configInfo := configurationRoot configurationInfoFor: class.
	versionInfo := configInfo baselines detect: [ :each | each versionString = versionString ].
	cmd := VSRemoveCommand target: versionInfo for: self.
	[ cmd execute ]
		valueSupplyingAnswers:
			{{'Are you sure you want to remove*'.
			true}}.
	self should: [ class project version: #bleedingEdge ] raise: MetacelloSymbolicVersionNotDefinedError.
	self should: [ class project version: versionString ] raise: MetacelloVersionDoesNotExistError