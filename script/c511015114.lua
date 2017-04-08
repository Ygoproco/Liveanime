--Gagaga Head (Manga)
function c511015114.initial_effect(c)
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f then
			mt.xyz_filter=function(mc) return mc and f(mc) end
		else
			mt.xyz_filter=function(mc) return true end
		end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				mt.maxxyzct=99
			else
				mt.maxxyzct=maxct
			end
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		if not maxct then maxct=ct end
		if alterf then
			e1:SetCondition(Auxiliary.XyzCondition2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetTarget(Auxiliary.XyzTarget2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetOperation(Auxiliary.XyzOperation2(f,lv,ct,maxct,alterf,desc,op))
		else
			e1:SetCondition(Auxiliary.XyzCondition(f,lv,ct,maxct))
			e1:SetTarget(Auxiliary.XyzTarget(f,lv,ct,maxct))
			e1:SetOperation(Auxiliary.XyzOperation(f,lv,ct,maxct))
		end
		e1:SetValue(SUMMON_TYPE_XYZ)
		c:RegisterEffect(e1)
	end

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
	--effect gain
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
	local tp=e:GetHandler():GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,2,nil,TYPE_MONSTER)
end
function c511015114.spfilter(c,e,tp)
	return c:IsSetCard(0x54) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015114.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511015114.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511015114.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,0,0)
end
function c511015114.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511015114.spfilter,tp,LOCATION_GRAVE,0,ct,ct,nil,e,tp)
	Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)

end
function c511015114.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c511015114.efop(e,tp,eg,ep,ev,re,r,rp)
	local n = e:GetHandler():GetReasonCard():GetOverlayGroup():FilterCount(Card.IsSetCard,nil,0x54)
	Duel.Draw(tp,n,REASON_EFFECT)
end

function c511015114.lvfilter(c,lv)
	return c:GetLevel()==lv
end
function c511015114.xyzfilter(c,m)
	return c:IsType(TYPE_XYZ) and
		m:IsExists(c511015114.lvfilter,m:GetCount(),nil,c:GetRank()) and
		m:GetCount()>=c.minxyzct and m:GetCount()<=c.maxxyzct and
		c:IsSetCard(0x48)
end
function c511015114.gafilter(c,xm)
	return c:IsSetCard(0x54) and c:IsCanBeXyzMaterial(xm)
end
function c511015114.xyztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		local m = Duel.GetMatchingGroup(c511015114.gafilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c511015114.xyzfilter,tp,LOCATION_GRAVE,0,1,nil,m) 
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015114.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local m = Duel.GetMatchingGroup(c511015114.gafilter,tp,LOCATION_MZONE,0,nil)
	local g = Duel.GetMatchingGroup(c511015114.xyzfilter,tp,LOCATION_GRAVE,0,nil,m) 
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		tc:SetMaterial(m)
		Duel.Overlay(tc,m)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,true,POS_FACEUP)
	end
end
