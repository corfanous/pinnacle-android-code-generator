<h1>Pinnacle Android Code Generator</h1>
<p>Generate android activity, fragment, setup recyclerview room entity and repository by specifying
the room data structure in a simple yaml file.
</p>
<p>
<b>Usage:</b>
Specify yaml file.<br/>
Example:
<p>
<code>
<pre>
User:
    fields:
        name: String
        email: String
        dateOfBirth: LocalDate
    imports:
       - "java.time.LocalDate"
    basePackageName: "com.example"
    packageName: "com.example.user"
</pre>
</code>
</p>
<p>
<b>Run Generator in command shell:</b><br/>
#>java -jar PinnacleAndroidCodeGenerator-0.0.9-SNAPSHOT.jar
</p>
<p>
This command launches the app interface. Select the generate from complex and generate from file.
</p>

 