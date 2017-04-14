--Red Gargoyle
--fixed by MLD
function c511009515.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511009515.spcon)
	c:RegisterEffect(e1)
	--double lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(975299,2))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009515.lvcon)
	e2:SetTarget(c511009515.lvtg)
	e2:SetOperation(c511009515.lvop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	if not c511009515.global_check then
		c511009515.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511009515.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009515.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511009515.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511009515.lvfilter(c,e,tp)
	return c:IsFaceup() and c420.IsRed(c) and c:GetLevel()>0 and c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c511009515.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return eg and eg:IsExists(c511009515.lvfilter,1,nil,nil,tp) 
		and not eg:IsContains(e:GetHandler())
end
function c511009515.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c511009515.lvfilter,e:GetHandler(),nil,tp)
	Duel.SetTargetCard(g)
end
function c511009515.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511009515.lvfilter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetLevel()*2)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
