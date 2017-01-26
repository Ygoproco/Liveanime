--Supreme King Dragon Zarc (Anime)
function c511009441.initial_effect(c)
	c:EnableUnsummonable()
	aux.EnablePendulumAttribute(c,false)
	--level/rank
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_RANK_LEVEL_S)
	c:RegisterEffect(e0)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511009441.splimit)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90036274,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCost(c511009441.spcost)
	e2:SetTarget(c511009441.sptg)
	e2:SetOperation(c511009441.spop)
	c:RegisterEffect(e2)
	--destroy and damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92170894,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCost(c511009441.damcost)
	e3:SetTarget(c511009441.damtg)
	e3:SetOperation(c511009441.damop)
	c:RegisterEffect(e3)
	--indestructable/immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c511009441.indcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e5)
	-- immune to leaving
	local e6=Effect.CreateEffect(c)
	e6:SetCode(EFFECT_SEND_REPLACE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCondition(c511009441.indcon)
	e6:SetTarget(c511009441.reptg)
	e6:SetOperation(c511009441.repop)
	c:RegisterEffect(e6)
	--immune to Fusion/Synchro/Xyz
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c511009441.efilter)
	c:RegisterEffect(e1)
	--special summon SK dragon
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(13331639,2))
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_BATTLE_DESTROYING)
	e8:SetCondition(aux.bdocon)
	e8:SetTarget(c511009441.sptg2)
	e8:SetOperation(c511009441.spop2)
	c:RegisterEffect(e8)
	--destroy drawn
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(13331639,0))
	e9:SetCategory(CATEGORY_DESTROY)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e9:SetCode(EVENT_TO_HAND)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCondition(c511009441.ddcon)
	e9:SetTarget(c511009441.ddtg)
	e9:SetOperation(c511009441.ddop)
	c:RegisterEffect(e9)
end
function c511009441.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(76794549)
end

-- summon Self
function c511009441.costfilter(c)
	return c:IsSetCard(0xf8)
end
function c511009441.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511009441.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511009441.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511009441.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009441.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	end
end

-- Destroy and damage
function c511009441.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c511009441.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009441.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009441.desfil,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		Duel.BreakEffect()
		local dam=dg:GetSum(Card.GetPreviousAttackOnField)
		if dg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,1-tp),1,nil) then Duel.Damage(1-tp,dam,REASON_EFFECT,true) end
		Duel.RDComplete()
	end
end


-- indestructable/immune
------------------------------
function c511009441.indfilterFusion(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) 
end
function c511009441.indfilterSynchro(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) 
end
function c511009441.indfilterXyz(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511009441.indcon(e)
	return Duel.IsExistingMatchingCard(c511009441.indfilterFusion,e:GetHandlerPlayer(),LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,1,nil)
	and Duel.IsExistingMatchingCard(c511009441.indfilterSynchro,e:GetHandlerPlayer(),LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,1,nil)
	and Duel.IsExistingMatchingCard(c511009441.indfilterXyz,e:GetHandlerPlayer(),LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_GRAVE+LOCATION_REMOVED,1,nil)
end
---------------------------------
-- immune to leaving
function c511009441.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_BATTLE) end
	return true
end
function c511009441.repop(e,tp,eg,ep,ev,re,r,rp)
	
end
--------------------------------------
-- Fusion/Synchro/Xyz
function c511009441.efilter(e,te)
	return te:IsActiveType(TYPE_FUSION) or te:IsActiveType(TYPE_SYNCHRO) or te:IsActiveType(TYPE_XYZ) 
end
---------------------------------
-- summon SK dragons
function c511009441.spfilter(c,e,tp)
	return c:IsSetCard(0x21fb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009441.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511009441.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and g:GetCount()>1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c511009441.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009441.spfilter,tp,LOCATION_EXTRA,0,2,2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
------------------------------------
-- to hand destroy
function c511009441.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c511009441.ddfilter(c,tp)
	return c:IsControler(1-tp)
end
function c511009441.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=nil
	if eg then g=eg:Filter(c511009441.ddfilter,nil,tp) end
	if chk==0 then return g and g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009441.ddop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c511009441.ddfilter,nil,tp)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
