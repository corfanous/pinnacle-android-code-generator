package ${classSpecification.packageName};

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import java.util.List;

public class ${classSpecification.name}ViewModel extends AndroidViewModel{

    private LiveData<List<${classSpecification.name}>> m${classSpecification.name}s;
    private ${classSpecification.name}Repo ${classSpecification.name?uncap_first}Repo;

    public ${classSpecification.name}ViewModel(@NonNull Application application) {
        super(application);
        ${classSpecification.name?uncap_first}Repo=new ${classSpecification.name}Repo(application);
        m${classSpecification.name}s=${classSpecification.name?uncap_first}Repo.getAll${classSpecification.name}s();
    }
    public void save(${classSpecification.name} ${classSpecification.name?uncap_first}){
        ${classSpecification.name?uncap_first}Repo.save(${classSpecification.name?uncap_first});
    }
    public void saveBlocked(${classSpecification.name} ${classSpecification.name?uncap_first}){
        ${classSpecification.name?uncap_first}Repo.saveBlocked(${classSpecification.name?uncap_first});
    }
    public LiveData<List<${classSpecification.name}>> getAll(){
        return m${classSpecification.name}s;
    }
    public List<${classSpecification.name}> getAllBlocked(){
        return ${classSpecification.name?uncap_first}Repo.getAllBlocked${classSpecification.name}s();
    }
    public LiveData<${classSpecification.name}> get(long id){
         return ${classSpecification.name?uncap_first}Repo.get${classSpecification.name}(id);
    }
    public ${classSpecification.name} getBlocked(long id){
         return ${classSpecification.name?uncap_first}Repo.getBlocked${classSpecification.name}(id);
    }
    public void delete(long id){
        ${classSpecification.name?uncap_first}Repo.delete${classSpecification.name}(id);
    }
}