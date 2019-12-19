import org.openapitools.codegen.*;
import org.openapitools.codegen.languages.*;
import org.openapitools.codegen.utils.ProcessUtils;

public class CustomRClientCodegen extends RClientCodegen {

    @Override
    public void processOpts() {
        super.processOpts();

        supportingFiles.add(new SupportingFile("utility_api.mustache", "R", "utility_api.R"));
 
        supportingFiles.add(new SupportingFile("utility_api_doc.mustache", apiDocPath, "UtilityApi.md"));
    }
}