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

hitta = (id) -> document.getElementById id

falt = "avgift ronder minuter".split " "

hamtaVarde = (id) ->
	value = parseFloat hitta(id).value
	if isNaN(value) then 0 else value

berakna = ->
	2 * hamtaVarde("ronder") * hamtaVarde("minuter") / hamtaVarde("avgift")

bygnadDom = ->
	body = document.body
	body.textContent = ""

	panel = Koppla "div", body, class: "panel"
	Koppla "h1", panel, text: "Beräkna antal minuter per krona"
	Koppla "p", panel, text: "Mata in avgift, antal ronder samt betänketid för olika klubbar och turneringar."

	skapaRad = (labelText, inputId, value) ->
		row = Koppla "div", panel, class: "row"
		label = Koppla "label", row, for: inputId, text: labelText
		Koppla "input", label, id: inputId, type: "number", value: value

	skapaRad "Avgift i kronor", "avgift", 800
	skapaRad "Antal ronder", "ronder", 40
	skapaRad "Betänketid i minuter (90 + 30 => 120)", "minuter", 120

	result = Koppla "div", panel, class: "result"
	result.textContent = "Minuter per krona: "
	Koppla "span", result, id: "resultat", text: "0"

init = ->
	bygnadDom()

	uppdateraSumma = ->
		total = berakna()
		hitta("resultat").textContent = total.toFixed 0

	for id in falt
		hitta(id).addEventListener "input", uppdateraSumma

	uppdateraSumma()

init()
