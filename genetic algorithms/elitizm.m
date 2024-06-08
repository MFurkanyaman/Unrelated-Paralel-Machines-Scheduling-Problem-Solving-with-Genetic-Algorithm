function [elit_value] = elitizm(ns_objectiveValues,ns_pop,p_size)
    
    

    [sorted_values, sorted_indices] = sort(ns_objectiveValues);
    
    % Elit birey sayısını belirleyin
    sayac = round(p_size * 0.1);

    % Elit bireyleri seçin
    elit_indices = sorted_indices(1:sayac);
    elit_values_sorted = sorted_values(1:sayac);

    % Elit bireylerin orijinal değerlerini alın
    elit_values_original = ns_objectiveValues(elit_indices);
    
    % Elit bireylerin hem sıralanmış hem de orijinal değerlerini tutan bir matris oluşturun
    elit_value = [elit_values_sorted, elit_indices];
end

