--Winged Kuriboh LV9 (Manga)
function c511018000.initial_effect(c)
	--cannot be special summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511018000.splimit)
	c:RegisterEffect(e1)
	--atk & def decreased cause pochyena
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetValue(c511018000.vatk)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetValue(c511018000.vdef)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511018000,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511018000.destg)
	e4:SetOperation(c511018000.desop)
	c:RegisterEffect(e4)
end
function c511018000.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(100000246)
end
function c511018000.filter(c)
	return c:GetReasonEffect():GetOwner():IsCode(100000246)
end
function c511018000.vatk(e)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c511018000.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local val=rg:GetSum(Card.GetAttack)
	return val
end
function c511018000.vdef(e)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c511018000.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local val=rg:GetSum(Card.GetDefense)
	return val
end
function c511018000.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511018000.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
--100000246 alchemy