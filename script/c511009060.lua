--White Prosperity
function c511009060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009060.target)
	e1:SetOperation(c511009060.operation)
	c:RegisterEffect(e1)
	if not c511009060.global_check then
		c511009060.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511009060.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009060.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511009060.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c420.IsWhite(c) 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,c,c:GetCode()) and c:IsLevelBelow(4) 
end
function c511009060.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511009060.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009060.filter,tp,LOCATION_HAND,0,2,nil,e,tp) end	
end
function c511009060.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511009060.filter,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	if tc:GetCount()~=2 then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end