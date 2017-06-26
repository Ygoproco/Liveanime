--Gagaga Head (Manga)
--fixed by MLD
--NOTE: Change Draw effect to trigger once implementable
function c511015114.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015114,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511015114.ntcon)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015114,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c511015114.sptg)
	e2:SetOperation(c511015114.spop)
	c:RegisterEffect(e2)
	--effect gain (changed)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCondition(c511015114.efcon)
	e3:SetOperation(c511015114.efop)
	c:RegisterEffect(e3)
	--xyz summon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511015114.xyztg)
	e4:SetOperation(c511015114.xyzop)
	c:RegisterEffect(e4)
end
function c511015114.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and c:GetLevel()>4 and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,2,nil,TYPE_MONSTER)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c511015114.spfilter(c,e,tp)
	return c:IsSetCard(0x54) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015114.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511015114.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511015114.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local tg=Duel.GetMatchingGroup(c511015114.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=nil
	if tg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=tg:Select(tp,ft,ft,nil)
	else
		g=tg
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511015114.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c511015114.efop(e,tp,eg,ep,ev,re,r,rp)
	local n = e:GetHandler():GetReasonCard():GetOverlayGroup():FilterCount(Card.IsSetCard,nil,0x54)
	Duel.Draw(tp,n,REASON_EFFECT)
end
function c511015114.xyzfilter(c,m,cc)
	if not c:IsType(TYPE_XYZ) or not c:IsSetCard(0x48) or not c.xyz_filter then return false end
	local e1=Effect.CreateEffect(cc)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetDescription(1073)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(aux.XyzCondition(c.xyz_filter,c:GetRank(),c.minxyzct,c.maxxyzct,false))
	e1:SetTarget(aux.XyzTarget(c.xyz_filter,c:GetRank(),c.minxyzct,c.maxxyzct,false))
	e1:SetOperation(aux.XyzOperation(c.xyz_filter,c:GetRank(),c.minxyzct,c.maxxyzct,false))
	e1:SetReset(RESET_CHAIN)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	local res=c:IsXyzSummonable(m,m:GetCount(),m:GetCount())
	e1:Reset()
	return res
end
function c511015114.gafilter(c)
	return c:IsSetCard(0x54) and c:IsFaceup()
end
function c511015114.xyztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local m=Duel.GetMatchingGroup(c511015114.gafilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c511015114.xyzfilter,tp,LOCATION_GRAVE,0,1,nil,m,e:GetHandler()) 
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015114.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local m=Duel.GetMatchingGroup(c511015114.gafilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c511015114.xyzfilter,tp,LOCATION_GRAVE,0,nil,m,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetDescription(1073)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCondition(aux.XyzCondition(tc.xyz_filter,tc:GetRank(),tc.minxyzct,tc.maxxyzct,false))
		e1:SetTarget(aux.XyzTarget(tc.xyz_filter,tc:GetRank(),tc.minxyzct,tc.maxxyzct,false))
		e1:SetOperation(aux.XyzOperation(tc.xyz_filter,tc:GetRank(),tc.minxyzct,tc.maxxyzct,false))
		e1:SetReset(RESET_CHAIN)
		e1:SetValue(SUMMON_TYPE_XYZ)
		tc:RegisterEffect(e1)
		Duel.XyzSummon(tp,tc,m)
	end
end
