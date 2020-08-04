<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
package ${classSpecification.packageName};

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import ${classSpecification.basePackageName}.R;
import ${classSpecification.basePackageName}.util.ClickListener;
import ${classSpecification.basePackageName}.util.RecyclerTouchListener;

import java.util.List;


public class ${classSpecification.name}ListFragment extends Fragment {
    //
    private ${classSpecification.name}ViewModel ${classSpecification.name?uncap_first}VM;
    private ${classSpecification.name}RecyclerViewAdapter adapter;
    //
    public ${classSpecification.name}ListFragment(){
        Bundle args=new Bundle();
        //args.putLong("patientId", CaseProvider.currentPatientId);
        //args.putLong("caseId", CaseProvider.currentCaseId);
        setArguments(args);
    }
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        View root = inflater
                .inflate(R.layout.fragment_list_${classSpecification.tableName}", container, false);
        //
        setHasOptionsMenu(true);//enable toolbar menu
        //
        Context context=root.getContext();
        if(root instanceof RecyclerView){
            RecyclerView rcv=(RecyclerView) root;
            adapter=new ${classSpecification.name}RecyclerViewAdapter(context);
            //
            adapter.setNewButtonClickListener(view -> {
                Intent i=new Intent(context, ${classSpecification.name}Activity.class);
                //i.putExtra("patientId",getArguments().getLong("patientId"));
                //i.putExtra("caseId",getArguments().getLong("caseId"));
                startActivity(i);
                //startActivityForResult(i,1);
            });
            rcv.setLayoutManager(new LinearLayoutManager(context));
            rcv.setAdapter(adapter);
            rcv.addOnItemTouchListener(new RecyclerTouchListener(getContext(), rcv, new ClickListener(){
                @Override
                public void onClick(View view, int position) {
                }
                @Override
                public void onLongClick(View view, int position) {
                    //navigate to edit form(${classSpecification.name}Activity#${classSpecification.name}FormFragment)
                }
            }));
        }
        return root;
    }
    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        //setup the view model
        ${classSpecification.name?uncap_first}VM=new ViewModelProvider(this).get(${classSpecification.name}ViewModel.class);
    }

    @Override
    public void onResume() {
        super.onResume();
        //${classSpecification.name?uncap_first}VM.init(CaseProvider.currentPatientId,CaseProvider.currentCaseId);
        ${classSpecification.name?uncap_first}VM.getAll().observe(getViewLifecycleOwner(), new Observer<List<${classSpecification.name}>>() {
            @Override
            public void onChanged(List<${classSpecification.name}> ${classSpecification.name?uncap_first}s) {
                if(${classSpecification.name?uncap_first}s instanceof List){
                    //adapter.initialize(null,${classSpecification.name?uncap_first}s);
                }
            }
        });
    }

    @Override
    public void onCreateOptionsMenu(@NonNull Menu menu, @NonNull MenuInflater inflater) {
        inflater.inflate(R.menu.menu_list_${classSpecification.tableName}",menu);
        super.onCreateOptionsMenu(menu, inflater);
    }
}