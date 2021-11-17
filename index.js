async function loadVerbali() {
    const response = await fetch("https://api.github.com/repos/Yakuzaishi-SWE/docs/contents/docs/verbali?ref=gh-pages");
    const verbali = await response.json();
    const ulEL = document.getElementById("verbali");
    for (let verbale of verbali) {
        let li = document.createElement("li");
        let a = document.createElement("a");
        a.setAttribute("href", verbale.path);
        a.innerText = verbale.name;
        li.appendChild(a);
        ulEL.appendChild(li);
    }
}

loadVerbali().then(() => {}).catch(err => console.error(err));
