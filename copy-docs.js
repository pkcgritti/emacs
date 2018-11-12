var target = 'Player';
var tbodies = document.getElementsByTagName('tbody');
var props = [].map.call(tbodies, tbody => {
    var trs = tbody.getElementsByTagName('tr');
    var syntax = trs[1];
    var description = trs[3];
    var name = syntax.innerText.split(/\s+/);
    var meta = description.innerText;
    name.shift();
    name.pop();
    return {
	name: name.join(''),
	meta
    };
});

props = props.filter(prop => prop.name.startsWith(target))
props.forEach(prop => {
    prop.name = prop.name.replace(target + '.', '');
    var index = prop.name.indexOf('(');
    if (index !== -1) {
	prop.args = prop.name.substr(index, prop.name.length).replace(',', ', ');
	prop.name = prop.name.substring(0, index);
    }
});
