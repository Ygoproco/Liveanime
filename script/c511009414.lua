--Performapal Dropgallop
--Fixed by TheOnePharaoh    
function c511009414.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511009414.con)
	e1:SetTarget(c511009414.tg)
	e1:SetOperation(c511009414.op)
	c:RegisterEffect(e1)
		--lv change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26082117,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009414.condition)
	e2:SetTarget(c511009414.target)
	e2:SetOperation(c511009414.operation)
	c:RegisterEffect(e2)
end
function c511009414.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM and eg:IsContains(e:GetHandler()) and eg:IsExists(c94693857.filter,1,nil)
end
function c511009414.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c511009414.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c24348804.filter,nil)
	local ct=g:GetCount()
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct)  end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511009414.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:GetCount()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
function c511009414.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(5)  
end
function c511009414.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009414.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c511009414.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local t={}
	local i=1
	local p=1
	local lv=e:GetHandler():GetLevel()
	for i=1,4 do 
		if lv~=i then t[p]=i p=p+1 end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26082117,1))
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
end
function c511009414.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
