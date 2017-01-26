--Engrave Soul Light
function c511002724.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511002724.filter)
	--atk change other
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4857085,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511002724.chtg)
	e4:SetOperation(c511002724.chop)
	c:RegisterEffect(e4)
	--atk change equip
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511002724.descon)
	e5:SetOperation(c511002724.desop)
	c:RegisterEffect(e5)
end
c511002724.collection={
	[58831685]=true;[10202894]=true;[65570596]=true;[511001464]=true;[511001094]=true;
	[68722455]=true;[58165765]=true;[45462639]=true;[511001095]=true;[511000365]=true;
	[14886469]=true;[30494314]=true;[81354330]=true;[86445415]=true;[100000562]=true;
	[34475451]=true;[40975574]=true;[37132349]=true;[61019812]=true;[19025379]=true;
	[76547525]=true;[55888045]=true;[97489701]=true;[67030233]=true;[65338781]=true;
	[45313993]=true;[8706701]=true;[21142671]=true;
}
function c511002724.filter(c)
	return (c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c:IsSetCard(0x89b) or c511002724.collection[c:GetCode()]) 
		and c:IsType(TYPE_SYNCHRO)
end
function c511002724.atkfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511002724.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002724.atkfilter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetEquipTarget():GetAttack()) end
end
function c511002724.chop(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetHandler():GetEquipTarget():GetAttack()
	local g=Duel.GetMatchingGroup(c511002724.atkfilter,tp,0,LOCATION_MZONE,nil,atk)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511002724.cfilter(c,tp)
	return c:GetPreviousControler()==1-tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002724.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002724.cfilter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:GetBaseAttack()~=e:GetHandler():GetEquipTarget():GetAttack()
end
function c511002724.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002724.cfilter,nil,tp)
	local tc=g:GetFirst()
	local eq=e:GetHandler():GetEquipTarget()
	if eq then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(tc:GetBaseAttack())
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		eq:RegisterEffect(e2)
	end
end
