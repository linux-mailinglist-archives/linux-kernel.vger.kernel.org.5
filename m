Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A586757633
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGRIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGRIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:07:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D2FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:07:51 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R4s3R0chwzVjDY;
        Tue, 18 Jul 2023 16:06:27 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 16:07:48 +0800
Message-ID: <2cc391ce-0e87-040f-6a45-d3e128a988f0@huawei.com>
Date:   Tue, 18 Jul 2023 16:07:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <andersson@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230530112746.2767-1-lihuisong@huawei.com>
 <02f74b25-2ade-5b87-b316-ab902f08ead2@huawei.com>
 <3e106062-9ceb-eb51-70ba-32734c769bd5@kernel.org>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3e106062-9ceb-eb51-70ba-32734c769bd5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your reply.


在 2023/7/17 20:06, Krzysztof Kozlowski 写道:
> On 14/07/2023 08:17, lihuisong (C) wrote:
>> Hi all,
>>
>> Can you take a look at this series?
> People you listed in "To:" field are not maintainers of HiSilicon, so
> why pinging us?
This "To:" field are from the get_maintainer.pl script.
./scripts/get_maintainer.pl -f ./drivers/soc/
The hisilicon in drivers/soc/ is created for the first time. So there 
are no maintainer of HiSilicon.

Thanks for reminder.
add HiSilicon SOC maintainer Wei Xu.
>
> HiSilicon DTS has numerous issues, so if you want to increase the
> chances anyone cares about your patch, please contribute to fixing and
> improving your company DTS. See for example commit b2bbc8687 which is
> bad (underscores are not allowed) or 1860a51823 which is just wrong. The
> latter one is being fixed, although I do not see the fix being picked
> up... my feelings are the platform is just dead.
The HCCS driver has nothing to do with HiSilicon DTS.
So I cannot understand why you say DTS.

/Huisong
