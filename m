Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB07E80EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbjKJSUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjKJSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:19 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0F24C19;
        Fri, 10 Nov 2023 01:38:20 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9cHfh105706;
        Fri, 10 Nov 2023 03:38:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699609097;
        bh=e/z4IobkrHCnPhosJZd5RkzB3izt0JqBTe790Ch3USA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aXnVgiQswlPad2DphWvUS9KS9ke9OqQuEI4Udip6nKoBg2vMcTxbLxfSYP2/4ovRS
         osigXOzZ3SfZeJ+xriXo6iBSHesyNsjDDLMJMEnsBg1pE5t1tqmWjsEVyEKpkfa7vZ
         GGMbvsOGfNDyf/EvHrQGaQBc/eoLCq3MN7rDezKc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AA9cHsr014520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 03:38:17 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 03:38:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 03:38:16 -0600
Received: from [172.24.227.247] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9cDOh027218;
        Fri, 10 Nov 2023 03:38:14 -0600
Message-ID: <44f68604-b37d-56d9-6fc1-4c4cc503abd3@ti.com>
Date:   Fri, 10 Nov 2023 15:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <nm@ti.com>, <srk@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>
References: <20231110084227.2616-1-r-gunasekaran@ti.com>
 <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

On 11/10/23 2:21 PM, Roger Quadros wrote:
> Hi Ravi,
> 
> On 10/11/2023 10:42, Ravi Gunasekaran wrote:
>> Grygorii is no longer associated with TI and messages addressed to
>> him bounce.
>>
>> Add Siddharth and myself as reviewers.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  MAINTAINERS | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7b151710e8c5..bd52c33bca02 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>  F:	drivers/counter/ti-eqep.c
>>  
>>  TI ETHERNET SWITCH DRIVER (CPSW)
>> -R:	Grygorii Strashko <grygorii.strashko@ti.com>
>> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
>> +R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Could you please add me as Reviewer as well. Thanks!

Thanks for volunteering to be a reviewer.

I posted a v2 adding you as a reviewer.
https://lore.kernel.org/all/20231110092749.3618-1-r-gunasekaran@ti.com/

> 
>>  L:	linux-omap@vger.kernel.org
>>  L:	netdev@vger.kernel.org
>>  S:	Maintained
> 
>> F:      drivers/net/ethernet/ti/cpsw*
>> F:      drivers/net/ethernet/ti/davinci*
> 
> What about am65-cpsw*?
> 
> And drivers/net/ethernet/ti/icssg/*

I would prefer a separate entry for ICSSG. Will let Danish comment on this.

> 
> I also see 
> 
> OMAP GPIO DRIVER
> M:      Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Maybe a separate patch to remove the invalid email-id?
> 
Yes, that's the plan. One of us from TI would be posting shortly.


-- 
Regards,
Ravi
