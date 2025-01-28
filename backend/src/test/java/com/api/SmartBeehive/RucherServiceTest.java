/*import com.api.SmartBeehive.entity.Rucher;
import com.api.SmartBeehive.service.RucherService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mockito;

class RucherServiceTest {

    private RucherService rucherService;

    @BeforeEach
    void setUp() {
        rucherService = new RucherService();
    }

    @Test
    void updateRucher() throws InterruptedException, ExecutionException {
        Rucher rucher = new Rucher();
        rucher.setNom("My Ruche");
        rucher.setDescription("This is my ruche.");
        rucher.setAdresse("123 Main Street");

        String rucherId = "my-ruche-id";
        String apiref = "my-apiref";

        Map<String, Object> updatedData = new HashMap<>();
        updatedData.put("nom", rucher.getNom());
        updatedData.put("description", rucher.getDescription());
        updatedData.put("adresse", rucher.getAdresse());

        // Mock the Firestore client and its chained methods
        Firestore mockFirestore = Mockito.mock(Firestore.class);
        CollectionReference mockRucherCollection = Mockito.mock(CollectionReference.class);
        DocumentReference mockRucherDocument = Mockito.mock(DocumentReference.class);
        ApiFuture<WriteResult> mockApiFuture = Mockito.mock(ApiFuture.class);

        Mockito.when(mockFirestore.collection("smartbeehive")).thenReturn(mockRucherCollection);
        Mockito.when(mockRucherCollection.document("app")).thenReturn(mockRucherDocument);
        Mockito.when(mockRucherDocument.collection("apiculteur")).thenReturn(mockRucherCollection);
        Mockito.when(mockRucherCollection.document(apiref)).thenReturn(mockRucherDocument);
        Mockito.when(mockRucherDocument.collection("rucher")).thenReturn(mockRucherCollection);
        Mockito.when(mockRucherCollection.document(rucherId)).thenReturn(mockRucherDocument);
        Mockito.when(mockRucherDocument.update(updatedData)).thenReturn(mockApiFuture);

        // Call the updateRucher() method
        String result = rucherService.updateRucher(rucher, rucherId, apiref);

        // Assert the result
        assertEquals("update failed", result);
    }
}*/

