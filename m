Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63BF77375C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHHDJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHHDIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:08:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6210DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:08:51 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKdR02rRqz1KBhS;
        Tue,  8 Aug 2023 11:07:40 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:08:49 +0800
Message-ID: <1ac78d35-0216-f231-5f80-323896e75689@huawei.com>
Date:   Tue, 8 Aug 2023 11:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] regulator: Make clkin_name and xin_name static
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20230807015027.21085-1-guozihua@huawei.com>
 <8c0e8e88-66cf-440c-942e-a897c7f8ef87@sirena.org.uk>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <8c0e8e88-66cf-440c-942e-a897c7f8ef87@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/7 21:36, Mark Brown wrote:
> On Mon, Aug 07, 2023 at 09:50:27AM +0800, GUO Zihua wrote:
>> clkin_name and xin_name is not referred elsewhere, so make them static.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>
>> v2:
>>   Re-formatted patch and tested on the most current master.
> 
> This still doesn't apply against my current tree, please check and
> resend.  It should apply against the for-6.6 branch.

Hi Mark,

This patch does not seems to be needed on next anymore. Please ignore it
and thanks for your time!

-- 
Best
GUO Zihua

