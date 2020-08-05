<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    tools:context="${classSpecification.packageName}.${classSpecification.name}Activity">
    <item
        android:id="@+id/new"
        android:icon="@drawable/ic_new_content_v_24dp"
        android:title="@string/add"
        android:checkable="true"
        android:orderInCategory="100"
        app:showAsAction="ifRoom"
        android:onClick="onClickNew${classSpecification.name}"/>
</menu>