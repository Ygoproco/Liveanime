--Performance Exchange
function c511004405.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004405.target)
	e1:SetOperation(c511004405.operation)
	c:RegisterEffect(e1)
end
function c511004405.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f) and Duel.IsExistingMatchingCard(c511004405.burnfilter,tp,LOCATION_ONFIELD,0,1,nil,c:GetLevel())
end
function c511004405.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004405.filter,tp,LOCATION_ONFIELD,0,1,nil) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	local tg=Duel.SelectTarget(tp,c511004405.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tg,1,tp,0)
end
function c511004405.burnfilter(c,lv)
	return c:IsType(TYPE_MONSTER) and c:IsLevelBelow(lv-1) and c:IsControlerCanBeChanged() and not c:IsType(TYPE_XYZ) 
end
function c511004405.operation(e,tp,eg,ev,ep,re,r,rp)
	local tg=Duel.GetFirstTarget()
	local lv=tg:GetLevel()
	local ctg=Duel.GetMatchingGroup(c511004405.burnfilter,tp,LOCATION_MZONE,0,nil,lv)
	local space=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	local count=ctg:GetCount()
	if space<count then
		count=space
	end
	if space>0 then
		ctg=ctg:FilterSelect(tp,Card.GetControler,count,count,nil)
		Duel.GetControl(ctg,1-tp,RESET_PHASE+PHASE_END,1)
	end
end