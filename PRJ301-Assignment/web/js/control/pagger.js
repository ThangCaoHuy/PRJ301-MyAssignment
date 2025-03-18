/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function renderPagger(id, pageindex, gap, totalpage)
{
    var container = document.getElementById(id);
    var content = '';

    if (pageindex !== 1)
        content += '<a href="list?page=1">First</a>';

    for (var i = pageindex - gap; i < pageindex; i++)
    {
        if (i > 1)
            content += '<a href="list?page=' + i + '">' + i + '</a>';
    }

    content += '<span>' + pageindex + '</span>';

    for (var i = pageindex + 1; i <= pageindex + gap; i++)
    {
        if (i < totalpage - gap)
            content += '<a href="list?page=' + i + '">' + i + '</a>';
    }

    if (pageindex !== totalpage)
        content += '<a href="list?page=' + totalpage + '">Last</a>';

    container.innerHTML = content;
}

