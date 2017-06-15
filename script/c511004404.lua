--Extra Shave Reborn
--fixed by MLD
function c511004404.initial_effect(c)
	--the effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511004404.condition)
	e1:SetTarget(c511004404.target)
	e1:SetOperation(c511004404.activate)
	c:RegisterEffect(e1)
	if not c511004404.global_check then
		c511004404.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PREDRAW)
		ge1:SetCountLimit(1)
		ge1:SetOperation(c511004404.gop)
		Duel.RegisterEffect(ge1,0)
	end 
end
function c511004404.gop(e,tp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511004404,0,0,0)
		tc=g:GetNext()
	end
end
function c511004404.prefilter(c,tp)
	return c:GetPreviousControler()==tp and bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER and c:GetLevel()>0 
		and c:GetFlagEffect(511004404)~=0
end
function c511004404.condition(e,tp,eg,ev,ep,re,r,rp)
	local cg=eg:Filter(c511004404.prefilter,nil,tp)
	local lv=cg:GetMaxGroup(Card.GetLevel)
	e:SetLabel(lv)
	return cg:GetCount()>0
end
function c511004404.filter(c,e,tp,lv)
	return c:GetFlagEffect(511004404)~=0 and c:GetLevel()<lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511004404.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	local lv=e:GetLabel()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511004404.filter(chkc,e,tp,lv) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511004404.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,lv) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectTarget(tp,c511004404.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,tg:GetCount(),0,0)
end
function c511004404.activate(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
