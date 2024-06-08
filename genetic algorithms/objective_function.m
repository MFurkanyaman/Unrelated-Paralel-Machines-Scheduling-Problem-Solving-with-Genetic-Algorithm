function [obj] = objective_function(population, s, p, p_size)
    obj = zeros(p_size, 1);

    % Her birey için amaç fonksiyonu değerini hesapla
    for i = 1:p_size
        chromosome = population{i};
        jobs_order = chromosome(1, :);  % İş sırası
        machine_numbers = chromosome(2, :);  % Makineler
        
        total_cost = 0;

         for machine = 1:max(machine_numbers)
            % Bu makinada işlenen işleri ve sıralarını alın
            machine_jobs_indices = find(machine_numbers == machine);
            machine_jobs = jobs_order(machine_jobs_indices);

            % Makinedeki işler arasında setup sürelerini topla
            for j = 1:length(machine_jobs) - 1
                job_i = machine_jobs(j);  % İş i
                job_j = machine_jobs(j+1);  % İş j
                total_cost = total_cost + s{machine}(job_j, job_i); % Setup süresi
            end
        end

        % İşleme süreleri terimi
        for j = 1:length(jobs_order)
            job_j = jobs_order(j);  % İş j
            machine = machine_numbers(j);  % Makine
            total_cost = total_cost + p(machine, job_j);
        end

        % Hesaplanan toplam maliyeti amaç fonksiyonu değerine ekle
        obj(i) = total_cost;
    end
end