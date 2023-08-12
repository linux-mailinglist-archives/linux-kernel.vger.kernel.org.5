Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0622779FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjHLLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjHLLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:50:30 -0400
Received: from out-74.mta0.migadu.com (out-74.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4435C5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:50:32 -0700 (PDT)
Message-ID: <25407bfd-0da9-7179-7c35-1fa1cc415ad2@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1691841031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4be5tytIVSZ8LL3WLA9aPAuFr/F6clSgpQCvB6Bgzgc=;
        b=D3IJLtEAjnsYm6FB7VVRWHKk1PrsNhaLOfj+RcBG39/hDxfnHjxo8oavIkfHB6utyZ3S8k
        66cTgrIM/1SFGsK4S1caXZ9ZP1bcYTIGSHAGmEOzr0AiLLvXcrsdELqRDFhwHDxh/fbVef
        EiFL9B2nHfU4c9L9yIBid+/6ucXbYEk=
Date:   Sat, 12 Aug 2023 12:50:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] dt-bindings: arm: qcom: Document MSM8x26-based Lumia
 phones
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20230811213728.23726-1-rayyan@ansari.sh>
 <20230811213728.23726-2-rayyan@ansari.sh>
 <b0494557-5676-4157-bc3b-bacd189c38d9@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <b0494557-5676-4157-bc3b-bacd189c38d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 23:58, Konrad Dybcio wrote:
> On 11.08.2023 23:35, Rayyan Ansari wrote:
>> Document MSM8226 and MSM8926 Lumias.
>>
>> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 450f616774e0..ea4b1c530461 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -181,9 +181,18 @@ properties:
>>   
>>         - items:
>>             - enum:
>> +              - microsoft,dempsey
>> +              - microsoft,makepeace
>> +              - microsoft,moneypenny
>>                 - samsung,s3ve3g
>>             - const: qcom,msm8226
>>   
>> +      - items:
>> +          - enum:
>> +              - microsoft,superman-lte
> The '9' in msm8926 means "LTE".. is there a non-LTE superman?
Yes, Lumia 730, based on MSM8226.
I didn't just make up this codename, the 735 is called superman_lte in 
internal files.

> 
> Konrad

-- 
Rayyan Ansari
https://ansari.sh

