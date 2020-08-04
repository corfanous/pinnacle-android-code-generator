<?xml version="1.0" encoding="utf-8"?>
<androidx.recyclerview.widget.RecyclerView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/${classSpecification.tableName}_list_id"
    android:name="${classSpecification.packageName}.${classSpecification.name}ListFragment"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:layout_marginLeft="16dp"
    android:layout_marginRight="16dp"
    app:layoutManager="LinearLayoutManager"
    tools:context="${classSpecification.packageName}.${classSpecification.name}ListFragment"
    tools:listitem="@layout/content_list_${classSpecification.packageName}"/>