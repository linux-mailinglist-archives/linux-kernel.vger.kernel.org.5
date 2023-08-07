Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C380771818
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHGBwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:51:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9C171B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:51:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RJzlx0LBQzVk0F;
        Mon,  7 Aug 2023 09:50:05 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 09:51:56 +0800
Message-ID: <0494994d-3820-b643-ac6f-20ab5e9066b9@huawei.com>
Date:   Mon, 7 Aug 2023 09:51:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] regulator: Make clkin_name and xin_name static
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20230804084634.30492-1-guozihua@huawei.com>
 <378e245d-4d85-4e61-8152-350f5aba179a@sirena.org.uk>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <378e245d-4d85-4e61-8152-350f5aba179a@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/4 20:29, Mark Brown wrote:
> On Fri, Aug 04, 2023 at 04:46:34PM +0800, GUO Zihua wrote:
>> clkin_name and xin_name is not referred elsewhere, so make them static.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> This doesn't apply against current code, please check and resend.

Hi Mark,

I re-made the patch against the latest master and sent a v2, Thanks!

-- 
Best
GUO Zihua

