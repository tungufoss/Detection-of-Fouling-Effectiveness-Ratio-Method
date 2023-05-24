% Author: Helga Ingimundardóttir
% Call: ratio = ratios ( method , methodParm , data , ts )
% Input: method: Function to approximate effectiveness
% methodParm: Parameters for the method
% data: Datasets to be used

% Output: ratio: Ratios for the effectiveness
% detect: When ratio first falls below threshold

function ratio_burn = ratios ( offset , method , methodParm , data, ts )
  if length( methodParm) == 4 % only the wavelet transfrom has 4 methodParm
    ts.boundarycondition = methodParm {4};
  else 
    ts.boundarycondition = 1;
  end
  ts.firstpt =1;

  % Ratio param
  ratio.offset = offset ;
  ratio.number_of_sets = data.nb ;
  ratio.intervals = floor(( ts.final - ts.begin ) / ratio.offset ) +1;


  for k=1:data.nb
    whom = k; where = ts.begin:ts.final ;
    c = struct (...
      'Tho', data.( data.name { whom }).clean.Tho ( where ) ,...
      'Tco', data.( data.name { whom }).clean.Tco ( where ) ,...
      'Thi', data.( data.name { whom }).clean.Thi ( where ) ,...
      'Tci', data.( data.name { whom }).clean.Tci ( where ) ,...
      'm_h', data.( data.name { whom }).clean.m_h ( where ) ,...
      'm_c', data.( data.name { whom }).clean.m_c ( where ) );
    f = struct (...
	'Tho', data.( data.name { whom }).fouling.Tho ( where ) ,...
	'Tco', data.( data.name { whom }).fouling.Tco ( where ) ,...
      'Thi', data.( data.name { whom }).fouling.Thi ( where ) ,...
      'Tci', data.( data.name { whom }).fouling.Tci ( where ) ,...
      'm_h', data.( data.name { whom }).fouling.m_h ( where ) ,...
      'm_c', data.( data.name { whom }).fouling.m_c ( where )) ;
    
    % Lowpass approximation for the given number of iterations
    j =0;
    for i= ts.begin:ratio.offset:ts.final
      j= j +1;
      f_tmp = method ( Eff (f.Thi (1:i) ,f.Tho (1:i) ,f.Tci (1:i )) , methodParm);
      c_tmp = method ( Eff (c.Thi (1:i) ,c.Tho (1:i) ,c.Tci (1:i )) , methodParm);

      ts.lastpt = floor ( length( c_tmp ) * ts.boundarycondition );

      f_tmp = f_tmp ( ts.firstpt:ts.lastpt );
      c_tmp = c_tmp ( ts.firstpt:ts.lastpt );

      ratio.f {k , j} = f_tmp /mean( f_tmp ) ;
      ratio.c {k , j} = c_tmp /mean( c_tmp ) ;

      ratio.N (j) = length( f_tmp ) ;

    end % end i for ratio
  end % end k for set

  ratio.final = ts.lastpt ;
  ratio.begin = floor (0.3* ratio.final );
  ratio_burn = cut_burnin( ratio );
end % Main function finished

%% --- AUXILIARY FUNCTIONS ---

function E = Eff ( Thi , Tho , Tci )
  E = ( Thi - Tho )./( Thi - Tci );
end
function ratio_burn = cut_burnin( ratio )
  for j =1:ratio.intervals
    if ratio.N( j) < ratio.begin
      burn_set = j +1;
    end
  end
  ratio.begin = ratio.N( burn_set ) ;

  ratio_burn.offset = ratio.offset ;
  ratio_burn.number_of_sets = ratio.number_of_sets ;
  ratio_burn.intervals = ratio.intervals - burn_set +1;
  ratio_burn.begin = ratio.begin ;
  ratio_burn.final = ratio.final ;
  ratio_burn.N = ratio.N( burn_set:end);
  for k =1:ratio.number_of_sets ;
  for j = burn_set:ratio.intervals
      ratio_burn.c {k ,j - burn_set +1}= ratio.c {k , j }( ratio.begin:end); % Henda burn - in svaedi
      ratio_burn.f{k ,j - burn_set +1}= ratio.f{k ,j }( ratio.begin:end); % Henda burn - in svaedi
    end
  end
end
