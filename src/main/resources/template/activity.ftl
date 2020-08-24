<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
package ${classSpecification.packageName};

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import ${classSpecification.basePackageName}.R;
import ${classSpecification.basePackageName}.util.Config;
import ${classSpecification.basePackageName}.util.NavigationHost;

public class ${classSpecification.name}Activity extends AppCompatActivity implements NavigationHost {

    private FloatingActionButton fab;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_<@toUnderScore camelCase="${classSpecification.name}"/>);
        Intent i=getIntent();
        //setup fad
        fab=(FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                fab.setVisibility(View.INVISIBLE);
                navigate(Config.VIEW_FORM);
            }
        });
        //navigate to fragment
        navigate(i.getIntExtra(Config.VIEW_MODE,0));
    }

    @Override
    public void navigateTo(Fragment fragment, boolean addToBackStack) {
        FragmentTransaction transaction=
                          getSupportFragmentManager()
                                  .beginTransaction()
                                  .replace(R.id.container, fragment);
        if(addToBackStack){
            transaction.addToBackStack(null);
        }
        transaction.commit();
    }

    protected void navigate(int viewMode){
        if(viewMode== Config.VIEW_FORM){
            fab.setVisibility(View.INVISIBLE);
            navigateTo(new ${classSpecification.name}FormFragment(),false);
        }else{
            navigateTo(new ${classSpecification.name}ListFragment(),false);
        }
    }
}