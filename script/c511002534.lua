--竜の束縛
function c511002534.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c511002534.filter,nil,nil,nil,0x1c0)
	--cannot spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c511002534.splimit)
	c:RegisterEffect(e2)
end
function c511002534.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511002534.splimit(e,c,tp,sumtp,sumpos)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and c:IsAttackBelow(tc:GetBaseAttack())
end
