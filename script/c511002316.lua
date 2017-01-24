--光学迷彩アーマー
function c511002316.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511002316.filter)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c511002316.con)
	c:RegisterEffect(e2)
end
function c511002316.filter(c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_FAIRY)
end
function c511002316.con(e)
	return not Duel.IsExistingMatchingCard(Card.IsAttackPos,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
