--Double Arms
function c511000280.initial_effect(c)
	aux.AddEquipProcedure(c)
	--double
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000280.damcon)
	e3:SetOperation(c511000280.damop)
	c:RegisterEffect(e3)
end
function c511000280.damcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	if eq~=re:GetHandler() then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex then return true end
	if not ex then return false end
end
function c511000280.damop(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetValue(c511000280.dammul)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
end
function c511000280.dammul(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	return val*2
end
