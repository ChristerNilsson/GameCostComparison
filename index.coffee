Koppla = ( typ, parent, attrs = {} ) ->
	elem = document.createElement typ

	if "text" of attrs
		elem.textContent = attrs.text
		delete attrs.text

	if "html" of attrs
		elem.innerHTML = attrs.html
		delete attrs.html

	for own key of attrs
		elem.setAttribute key, attrs[key]

	parent.appendChild elem
	elem

berakna = -> avgift.value / (2 * ronder.value * minuter.value / 60)

bygnadDom = ->
	body = document.body
	body.textContent = ""

	panel = Koppla "div", body, class: "panel"
	Koppla "h1", panel, text: "Beräkna antal kronor per timme"
	Koppla "p", panel, text: "Mata in avgift, antal ronder samt betänketid för olika klubbar och turneringar. Genom att räkna med blixt, snabb och lagaktiviteter samt tänka länge kan du sänka kostnaden ytterligare."

	skapaRad = (labelText, inputId, value) ->
		row = Koppla "div", panel, class: "row"
		label = Koppla "label", row, for: inputId, text: labelText
		Koppla "input", label, id: inputId, value: value, type: "number"

	avgift = skapaRad "Avgift i kronor", "avgift", 800
	ronder = skapaRad "Antal ronder", "ronder", 40
	minuter = skapaRad "Betänketid i minuter (90 + 30 => 120)", "minuter", 120

	result = Koppla "div", panel, class: "result", text: "Kronor per timme: "
	resultat = Koppla "span", result, id: "resultat", text: "0"

init = ->
	bygnadDom()

	uppdatera = -> resultat.textContent = berakna().toFixed 2

	avgift.addEventListener "input", uppdatera
	ronder.addEventListener "input", uppdatera
	minuter.addEventListener "input", uppdatera

	uppdatera()

init()
