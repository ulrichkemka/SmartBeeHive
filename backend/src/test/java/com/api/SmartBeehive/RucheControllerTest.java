package com.api.SmartBeehive;

import static org.hamcrest.CoreMatchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.api.SmartBeehive.controller.RucheController;
import com.api.SmartBeehive.service.RucheService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(controllers = RucheController.class)
public class RucheControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private RucheService rucheService;

    @Test
    public void testGetRuchesByUserIdOK() throws Exception {
        String userId = "userOK";
        String rucherId = "rucherOK";
        mockMvc.perform(get("/user/rucher/ruche/{userId}/{rucherId}", userId, rucherId))
                .andExpect(status().isOk());
    }

    @Test
    public void testGetRuchesByUserIdKO() throws Exception {
        String userId = "userKO";
        mockMvc.perform(get("/user/rucher/ruche/{userId}", userId))
                .andExpect(status().isNotFound());
    }

    @Test
    public void testSaveRuche() throws Exception {
        String userId = "user";
        String rucherId = "rucherKO";
        mockMvc.perform(get("/user/rucher/ruche/{userId}/{rucherId}", userId, rucherId))
                .andExpect(status().isOk());
    }
}
