Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84417633EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjGZKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjGZKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:37:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F602127
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:36:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QAaecI018115;
        Wed, 26 Jul 2023 05:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690367800;
        bh=1B0MDuc+ApzvvO3kxA++pppssIfBmpbwHLhnpmlFZXI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=iu4IYUJ0BJAHe2vg1m85sp9aYBPjJwr0QgP0j1OEo72IUUrn4ummwG6a4CrzdRK8P
         xTHMqOSk9AeEjHxizOITnk8XbzJ8IgqV/mCX3e5VpMnoVSRTFuN3VfiG3D8wz6Pp+w
         040vrFUs1uRrMyRYs1p4LLQTG6BsgPMQZOCj/CMI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QAaeqM003359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 05:36:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 05:36:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 05:36:39 -0500
Received: from [172.24.19.130] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QAabEh078104;
        Wed, 26 Jul 2023 05:36:38 -0500
Message-ID: <9b20a155-f662-cfce-c617-f21901841ef2@ti.com>
Date:   Wed, 26 Jul 2023 16:06:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for HYPERBUS
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230620025359.33839-1-tudor.ambarus@linaro.org>
 <20230622102836.2be2ab1b@xps-13> <20230710114903.352bc12d@xps-13>
Content-Language: en-US
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230710114903.352bc12d@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 3:19 PM, Miquel Raynal wrote:
> 
> miquel.raynal@bootlin.com wrote on Thu, 22 Jun 2023 10:28:57 +0200:
> 
>> Hi Vignesh,
>>
>> tudor.ambarus@linaro.org wrote on Tue, 20 Jun 2023 05:53:59 +0300:
>>
>>> Add myself as Designated Reviewer for Hyperbus support.
>>> I'm assessing the framework and I'd like to get involved
>>> in reviewing further patches.  
>>
>> Vignesh, any chance you could give feedback on this patch quickly? I'd
>> like to take it for the next PR if you agree.
> 
> I'm surprised there is still no feedback after 3 weeks, I haven't heard
> from him at all since a while.
> 
> Vignesh, are you still around?

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>


Thanks Tudor for taking signing up. And sorry for the delay.

Regards
Vignesh
