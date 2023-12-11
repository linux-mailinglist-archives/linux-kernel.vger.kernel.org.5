Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE680D349
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbjLKRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLKRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:09:43 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CEBD;
        Mon, 11 Dec 2023 09:09:49 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BBCOhHn012101;
        Mon, 11 Dec 2023 18:09:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=mBJKy1rd9gg9AQuGgxfNHb9qOFrFe4Ef73PNfhVbtc4=; b=RI
        1LWxR52FFW4lDBc0VsEERBbgaHACkd7ysFmBnN3M+9f0f7LTO6DgeSIxN7rMB3Um
        zHeXnfMbznFIsLtfDLy2KHfgaGec0J9mMuWvnSXoX9e+KJygSdRC4By+/T/6vpYo
        14HJ1QUOhM7YJIj2EI78B6T8lzUgR0OcE9EDnZXDRPQ3HRJNKEpQX+Oq67OONhf9
        RTNzdUXZyucR0yHc+J4Vdb5NWQF5Mh9Dpx+guu/Ij2ob8kZctsaV9e7eHcMec3ym
        O08C0R2thMpbur0smAl1dVXb2Oz5koSp4kmCgCZK1O0eMUZ7k9bXlwrZNB8f7UJY
        mbuuzwpJNongBHYhIYow==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0gqnvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:09:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 834FC10005C;
        Mon, 11 Dec 2023 18:09:46 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A7F929D80F;
        Mon, 11 Dec 2023 18:09:46 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 18:09:45 +0100
Message-ID: <81bbf2f7-6db2-47de-9761-0b196b5348d2@foss.st.com>
Date:   Mon, 11 Dec 2023 18:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] MAINTAINERS: add myself as counter watch events
 tool maintainer
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
 <ZXcx+94QW2pWDBxM@ubuntu-server-vm-macos>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZXcx+94QW2pWDBxM@ubuntu-server-vm-macos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 16:59, William Breathitt Gray wrote:
> On Wed, Dec 06, 2023 at 05:47:26PM +0100, Fabrice Gasnier wrote:
>> Add MAINTAINERS entry for the counter watch events tool. William has
>> been asking to add at least me as the point of contact for this utility.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in v3: Add MAINTAINERS entry. This is a split of another patch
>> series[1].
>> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
>> ---
>>  MAINTAINERS | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dd5de540ec0b..b8541ab7866a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5322,6 +5322,11 @@ F:	include/linux/counter.h
>>  F:	include/uapi/linux/counter.h
>>  F:	tools/counter/
>>  
>> +COUNTER WATCH EVENTS TOOL
>> +M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> +S:	Maintained
>> +F:	tools/counter/counter_watch_events.c
> 
> Add an L line as well for the linux-iio@vger.kernel.org address so
> discussions get sent to our public mailing list.

Hi William,

I can add it, yes. But just to be sure, with current patch,
get_maintainer.pl gives me:

./scripts/get_maintainer.pl tools/counter/counter_watch_events.c
Fabrice Gasnier <fabrice.gasnier@foss.st.com> (maintainer:COUNTER WATCH
EVENTS TOOL)
William Breathitt Gray <william.gray@linaro.org> (maintainer:COUNTER
SUBSYSTEM)
linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

So is it really needed to add an L line ?

Best Regards,
Fabrice

> 
> Thanks,
> 
> William Breathitt Gray
