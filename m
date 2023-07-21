Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059C75CAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjGUPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGUPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:04:40 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71E272D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:04:39 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEfUjc031690;
        Fri, 21 Jul 2023 17:04:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vX6N7XGJvQJZDqcaxGp+qHNQlwyBDcnlYDyxQFcb864=;
 b=owY9XcUxsxKM+piw4rzIV2OTg7gG/uBWnmdEsU63jyeSZb3vVHWVYGtpJlw0d1r2QpC9
 Ib7ysEVFxgvJd6PU/O/nNGZkDMybcLkAhb5ZwJ+rK1BiwpEjUniFHMLiTtQAejwYSKXb
 cyJjg08j3czstoYZWKwVCV9/8chCA0v5W06RlHczG8eqtMsC3wInf1lpI5H7Ho5dzvvv
 ixffwAc+3QUJmlQ7JMYBlcWd8YEQLhKFCz/fPbXerrOfTnu3yzAAcuH0qiYoj9rFydOY
 HWr4aUy0b3oWW059HZ+t3kadfsL3Ds9u+Qh/UQ2SZ304WwOBVnWI3C+Ec+d9x1HiXuOm /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rynjsufgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 17:04:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 848F910002A;
        Fri, 21 Jul 2023 17:04:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F65424B8BD;
        Fri, 21 Jul 2023 17:04:21 +0200 (CEST)
Received: from [10.252.20.152] (10.252.20.152) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 21 Jul
 2023 17:04:20 +0200
Message-ID: <749bc117-72c9-1d16-a41d-6fdf33bd40f2@foss.st.com>
Date:   Fri, 21 Jul 2023 17:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH] MAINTAINERS: Update Alain Volmat's email address for
 drm/sti
To:     <arnd@arnd.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Alain Volmat <avolmat@me.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20230416202747.62479-1-avolmat@me.com>
 <c8c9a22f-3b35-9c4e-21bd-b9695866be32@foss.st.com>
Content-Language: en-US
In-Reply-To: <c8c9a22f-3b35-9c4e-21bd-b9695866be32@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.20.152]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 08:33, Patrice CHOTARD wrote:
> Hi Alain
> 
> On 4/16/23 22:27, Alain Volmat wrote:
>> Update my email address for maintainer of the STi DRM driver.
>>
>> Signed-off-by: Alain Volmat <avolmat@me.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0e64787aace8..3cec7ad72389 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6952,7 +6952,7 @@ F:	Documentation/devicetree/bindings/display/rockchip/
>>   F:	drivers/gpu/drm/rockchip/
>>   
>>   DRM DRIVERS FOR STI
>> -M:	Alain Volmat <alain.volmat@foss.st.com>
>> +M:	Alain Volmat <avolmat@me.com>
>>   L:	dri-devel@lists.freedesktop.org
>>   S:	Maintained
>>   T:	git git://anongit.freedesktop.org/drm/drm-misc
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Dear Arnd,

May we ask you please to apply this patch (maybe on "soc/soc.git 
(arm/fixes)") as you did previously for a similar DRM/STI serie [1]?

Many thanks
Philippe :-)

[1] 
https://lore.kernel.org/all/164431157889.18327.10086136061531044985.git-patchwork-notify@kernel.org/


> 
> Thanks
> Patrice
