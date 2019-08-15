   <ul>
    <cfoutput>
        <cfloop from="1" to="20" index="i">
            <li>
                <input type="text" value="#createuuid()#" size="50"/>
            </li>
        </cfloop>

    </cfoutput>
</ul> 