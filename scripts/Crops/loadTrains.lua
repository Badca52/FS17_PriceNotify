function priceNotify:loadTrains()
  -- save trains for later
		for k, steerable in pairs(g_currentMission.steerables) do
			if steerable ~= nil then
				if steerable.trainSystem ~= nil then
					table.insert(priceNotify.trains, steerable);
				end;
			end;
		end;
end;
