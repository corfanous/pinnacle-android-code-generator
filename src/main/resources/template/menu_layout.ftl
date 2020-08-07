<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    tools:context="${classSpecification.packageName}.${classSpecification.name}Activity">
    <item
        android:id="@+id/search_${classSpecification.tableName}"
        android:title="@string/search"
        android:icon="@drawable/ic_launcher_background"
        android:orderInCategory="100"
        app:showAsAction="always"
        app:actionViewClass="androidx.appcompat.widget.SearchView"/>
</menu>