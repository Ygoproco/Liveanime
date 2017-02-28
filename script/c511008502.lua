--Split Guard
-- [Trap Continuos]
function c511008502.initial_effect(c)

	-- [Effect e1]: Activate this card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)

	-- [Effect e2]: Indestruct each Monster (once by turn)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE) -- Monsters in (my field, opponent field)
	e2:SetTarget(c511008502.target)
	e2:SetCondition(c511008502.condition)
	e2:SetValue(c511008502.indct)
	c:RegisterEffect(e2)
end

--- ######################## <Effect e2> ################### ---


function c511008502.target(e,c)
	return c511008502.filterCondition(c)
end


function c511008502.condition(e,tp,eg,ep,ev,re,r,rp)
	-- Condition: 2 o more monsters (face-up and not-token) with the same name in your field.
	local g=Duel.GetMatchingGroup(c511008502.filterCondition,tp,LOCATION_MZONE,0,nil)
	local ct=c511008502.get_countMonsterWithSameName(g)
	return ct>=2
	--return Duel.IsExistingTarget(c511008502.filterCondition,tp,LOCATION_MZONE,0,2,nil,tp)
end


function c511008502.filterCondition(c)
	return c:IsFaceup()  
	--return c:IsFaceup() and not c:IsType(TYPE_TOKEN) and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,c:GetCode())
end

function c511008502.get_countMonsterWithSameName(g)
	-- g: Group (of Cards)
	-- return ret: max num of monster with the same name
	if g:GetCount()==0 then return 0 end
	local ret=0
	repeat
		local tc=g:GetFirst()
		g:RemoveCard(tc)
		local ct1=g:GetCount()
		g:Remove(Card.IsCode,nil,tc:GetCode())
		local ct2=g:GetCount()
		local c=ct1-ct2+1
		if c>ret then ret=c end
	until g:GetCount()==0 or g:GetCount()<=ret
	return ret
end


function c511008502.indct(e,re,r,rp)
	-- If the reason for its destruction is by battle or effect, deny that destruction 1 time.
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else 
		return 0 
	end
end

--- ######################## </Effect e2> ################### ---