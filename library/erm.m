function [ objConst , correct , detect_times , th ] = ERM ( offset , submethod , subparm , train , test )
  % Author : Helga Ingimundardóttir
  % Call : [ objConst , correct , detect_times , th ] = ERM ( offset , submethod , subparm , train , test )
  % Input : offset = ERM offset
  % submethod = ERM sub method , either WT or MA
  % subparm = parameters for ERM ’s sub method
  % train = training data
  % test = test data
  % Output : objConst = objective functions for ERM
  % correct = boolean , 1 if correct classifiction , 0 otherwise
  % detect_times = dection times for fouling
  % th = ERM threshold
  ratio.train = ratios ( offset , @submethod , subparm , train , ts );
  
  ratio.test = ratios ( offset , @submethod , subparm , test , ts);

  th = compute_threshold ( ratio . train );

  [ detect_times . train , correct . train ] = detection ( ratio.train , th );
  objConst.train(1) = mean( correct.train.f );
  objConst.train(2) = mean( correct.train.c );
  objConst.train(3) = mean( detect_times.train.f )/ ts.final ;

  [ detect_times . test , correct . test ] = detection ( ratio.test , th );
  objConst.test(1) = mean( correct.test.f);
  objConst.test(2) = mean( correct.test.c);
  objConst.test(3) = mean( detect_times.test.f)/ ts.final ;

end
