package ${classSpecification.packageName};

import android.app.Application;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import java.util.List;
import ${classSpecification.basePackageName}.db.CovidRoomDatabase;

public class ${classSpecification.name}Repo {

    private ${classSpecification.name}Dao m${classSpecification.name}Dao;
    private LiveData<List<${classSpecification.name}>> m${classSpecification.name}s;

    public ${classSpecification.name}Repo(Application application){
        CovidRoomDatabase db=CovidRoomDatabase.getInstance(application);
        m${classSpecification.name}Dao=db.${classSpecification.name?uncap_first}Dao();
        m${classSpecification.name}s=m${classSpecification.name}Dao.findAll();
    }
    public void saveBlocked(${classSpecification.name} ${classSpecification.name?uncap_first}){
        //
        if(${classSpecification.name?uncap_first} instanceof ${classSpecification.name}){
            if(${classSpecification.name?uncap_first}.getId()>0){
                m${classSpecification.name}Dao.update(${classSpecification.name?uncap_first});
            }else{
                m${classSpecification.name}Dao.insert(${classSpecification.name?uncap_first});
            }
        }
    }
    public void save(${classSpecification.name} ${classSpecification.name?uncap_first}){
        CovidRoomDatabase.databaseWriterExecuter.execute(()->{
            if(${classSpecification.name?uncap_first} instanceof ${classSpecification.name}){
                if(${classSpecification.name?uncap_first}.getId()>0){
                    m${classSpecification.name}Dao.update(${classSpecification.name?uncap_first});
                }else{
                    m${classSpecification.name}Dao.insert(${classSpecification.name?uncap_first});
                }
            }
        });
    }
    public LiveData<${classSpecification.name}> get${classSpecification.name}(long id){
         return m${classSpecification.name}Dao.findById(id);
    }
    public ${classSpecification.name} getBlocked${classSpecification.name}(long id){
         return m${classSpecification.name}Dao.findByIdBlocked(id);
    }
    public LiveData<List<${classSpecification.name}>> getAll${classSpecification.name}s(){
         return m${classSpecification.name}s;
    }
    public List<${classSpecification.name}> getAllBlocked${classSpecification.name}s(){
         return m${classSpecification.name}Dao.findAllBlocked();
    }
    public void delete${classSpecification.name}(long id){
        m${classSpecification.name}Dao.delete(id);
    }
}