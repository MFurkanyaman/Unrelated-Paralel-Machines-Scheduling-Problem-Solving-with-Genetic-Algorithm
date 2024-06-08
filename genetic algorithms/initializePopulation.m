function [population] = initializePopulation(as, num_jobs, num_machines, p_size)
    population = cell(p_size, 1); % Hücre dizisi oluştur
    
    for i = 1:p_size
        % Her bir bireyin işler arasında rastgele bir sıralama yap
        jobs_order = randperm(num_jobs);
        machine_numbers = randi([as, num_machines], as, num_jobs);
        
        % Her bir bireyi tek bir matriste birleştir
        chromosome = vertcat(jobs_order, machine_numbers);
        
        % Kromozomu hücre dizisine ekle
        population{i} = chromosome;
    end
end