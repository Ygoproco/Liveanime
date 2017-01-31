--Net Resonator
function c511009513.initial_effect(c)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c511009513.condition)
	e2:SetOperation(c511009513.operation)
	c:RegisterEffect(e2)
end
function c511009513.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c511009513.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(511009513)==0 then
			--cannot special summon
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(511009513,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_NO_EFFECT_DAMAGE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetAbsoluteRange(ep,1,0)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(511009513,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end
