Return-Path: <linux-kernel+bounces-12601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CA81F778
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111DC28116E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0466FC9;
	Thu, 28 Dec 2023 11:02:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D06FB6;
	Thu, 28 Dec 2023 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B804D2F4;
	Thu, 28 Dec 2023 03:03:23 -0800 (PST)
Received: from [192.168.151.22] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981AA3F5A1;
	Thu, 28 Dec 2023 03:02:33 -0800 (PST)
Message-ID: <cf5d97d0-ae79-9524-fc19-a73d4403a3d0@arm.com>
Date: Thu, 28 Dec 2023 11:02:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jinlong Mao <quic_jinlmao@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, coresight@lists.linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
 <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
 <c41ff7c8-48d6-4f4f-a9df-aafe953a2e98@linaro.org>
 <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
 <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
 <16932826-fcc2-49d3-95ab-201eff729360@quicinc.com>
 <d4c6c32f-b1cf-4cf2-9c52-85fa8c1ed73f@linaro.org>
 <9d13e1ce-38b1-4cdd-83ba-eca0c3091ce1@quicinc.com>
 <578d6319-5ab5-45e5-8457-00116c7c84ae@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <578d6319-5ab5-45e5-8457-00116c7c84ae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/12/2023 09:36, Krzysztof Kozlowski wrote:
> On 26/12/2023 02:50, Jinlong Mao wrote:
>>
>>
>> On 12/21/2023 4:44 PM, Krzysztof Kozlowski wrote:
>>> On 21/12/2023 09:36, Jinlong Mao wrote:
>>>>
>>>>
>>>> On 12/21/2023 4:17 PM, Krzysztof Kozlowski wrote:
>>>>> On 21/12/2023 09:15, Jinlong Mao wrote:
>>>>>>
>>>>>>
>>>>>> On 12/21/2023 4:12 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 21/12/2023 04:28, Jinlong Mao wrote:
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>> index f725e6940993..cbf583d34029 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>> @@ -23,7 +23,7 @@ description: |
>>>>>>>>>>      
>>>>>>>>>>      properties:
>>>>>>>>>>        $nodename:
>>>>>>>>>> -    pattern: "^ete([0-9a-f]+)$"
>>>>>>>>>> +    pattern: "^ete-([0-9a-f]+)$"
>>>>>>>>>
>>>>>>>>> My concerns are not resolved. Why is it here in the first place?
>>>>>>>>
>>>>>>>> Hi Krzysztof,
>>>>>>>>
>>>>>>>> ETE is acronym of embedded trace extension. The number of the name is
>>>>>>>> the same as the number of the CPU it belongs to.
>>>>>>>
>>>>>>> This is obvious and was not my question.
> 
> You already said it here...
> 
>>>>>>
>>>>>> Do you mean why the pattern match of the node name is added here ?
>>>>>
>>>>> Yes, especially that it is requiring a non-generic name.
>>>>>
>>>>>>
>>>>>> This node should not have the node name match, right ?
>>>>>
>>>>> Usually. For sure shouldn't be for non-generic names.
>>>>>
>>>> Hi Suzuki,
>>>>
>>>> Can we remove the pattern match of the node name and use a generic name
>>>> "ete" for the ete DT nodes ?
>>>
>>> "ete" is not a generic name. What is generic here? It's an acronym of
>>> some specific device name.
>>>
>>
>> The device full name is embedded trace extension. So use ETE as the name 
>> here.
> 
> That's obvious and my comment was not about it. Second time... This is
> my unlucky day... I said, why do you even want to enforce name which is
> not generic, since the names should be generic?
> 

I think we can just drop the enforced name if it's getting in the way.
It doesn't really do anything and other Coresight bindings don't have it
anyway.

> I assume you read the DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> Best regards,
> Krzysztof
> 

I couldn't find anything in that list that would be a good fit for a
name, and it seems like all of the Coresight devices have already been
added with non generic names (like funnel and replicator etc), so it
might be a bit late now.

But if we drop the enforced name then it's probably fine.

James

