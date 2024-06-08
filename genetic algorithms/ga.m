function [output, objectiveValues, elit_value, crossoverInfo] = ga(population, ns_objectiveValues, num_machines, p_size, s, p, pcross, d, pmutation, iteration,  epoch, old_elit_value)

    if exist('old_elit_value', 'var')
        old_elit_value = old_elit_value; 
    end
    % Doğal seçilim uygulayın
    ns_pop = natural_selection(population, ns_objectiveValues, p_size);
    elit_value = elitizm(ns_objectiveValues,ns_pop, p_size);
    
    % Çaprazlama işlemini gerçekleştir ve çaprazlama bilgilerini al
    [child_pop, crossoverInfo] = crossover(ns_pop, p_size, pcross, d);
    
    % Mutasyon işlemini gerçekleştir
    child_pop = mutation(child_pop, pmutation, p_size, d, num_machines);
    
    % Mutasyon sonrası amaç fonksiyonu değerlerini hesapla
    child_objectiveValues = objective_function(child_pop, s, p, p_size);
     if exist('old_elit_value', 'var')
        [newPopulation, bestFit]  = find_best(population, ns_objectiveValues, child_pop, p_size, child_objectiveValues, elit_value, old_elit_value);
     else
        [newPopulation, bestFit]  = find_best(population, ns_objectiveValues, child_pop, p_size, child_objectiveValues, elit_value);
     end
    
    % Popülasyonu, amaç fonksiyon değerlerini ve doğal seçilim sonrası popülasyonu döndür
    resultLog(newPopulation, bestFit, iteration, epoch);
    % population=newPopulation;
    output = newPopulation;
    objectiveValues = bestFit;
    
 
end
