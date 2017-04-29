--Extra Shave Reborn
function c511004404.initial_effect(c)
	--the effect
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROY)
	e1:SetCondition(c511004404.con)
	e1:SetTarget(c511004404.tg)
	e1:SetOperation(c511004404.op)
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
	local extra=Duel.GetMatchingGroup(Card.GetControler,tp,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	local ex=extra:GetFirst()
	while ex do
		ex:RegisterFlagEffect(511004404,0,0,0)
		ex=extra:GetNext()
	end
end
function c511004404.prefilter(c,tp)
	return c:GetPreviousControler()==tp and bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER and c:GetFlagEffect(511004404)~=0 and not (c:IsType(TYPE_XYZ) and not (c:IsHasEffect(EFFECT_RANK_LEVEL) or c:IsHasEffect(EFFECT_RANK_LEVEL_S)))
end
function c511004404.con(e,tp,eg,ev,ep,re,r,rp)
	local cg=eg:Filter(c511004404.prefilter,nil,tp)
	local rg,lv=eg:GetMaxGroup(Card.GetLevel)
	e:SetLabel(lv)
	return eg:IsExists(c511004404.prefilter,1,nil,tp)
end
function c511004404.filter(c,e,tp,lv)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()<lv and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and c:GetFlagEffect(511004404)~=0 and not (c:IsType(TYPE_XYZ) and not (c:IsHasEffect(EFFECT_RANK_LEVEL) or c:IsHasEffect(EFFECT_RANK_LEVEL_S)))
end
function c511004404.tg(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511004404.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,e:GetLabel())
	end
	local tg=Duel.SelectTarget(tp,c511004404.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,tg:GetCount(),0,0)
end
function c511004404.op(e,tp,eg,ev,ep,re,r,rp)
	local tg=Duel.GetFirstTarget()
	if tg then
		Duel.SpecialSummon(tg,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
	end
end
