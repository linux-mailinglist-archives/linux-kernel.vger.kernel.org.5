Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87CC785474
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHWJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHWJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:42:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524581BCB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:38:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RW1Lw2V5bzrSZX;
        Wed, 23 Aug 2023 17:36:40 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 17:38:10 +0800
CC:     <yangyicong@hisilicon.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <hejunhao3@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: Update email
 addresses of HISILICON_PMU driver maintainers.
To:     Jijie Shao <shaojijie@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>
References: <20230822122812.2384393-1-shaojijie@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <16eeb96b-ffc5-1ab3-ba73-52015a027f94@huawei.com>
Date:   Wed, 23 Aug 2023 17:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230822122812.2384393-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jijie,

Actually we are not only update the email address but also the maintainers.
So the subject should be like:

drivers/perf: hisi: Update HiSilicon PMU maintainers

On 2023/8/22 20:28, Jijie Shao wrote:
> Since Guangbin and Shaokun have left HiSilicon and will no longer
> maintain the drivers, update the maintainer information and
> thanks for their work.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4171d3a102a9..a3109267a411 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9305,7 +9305,7 @@ F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
>  F:	drivers/crypto/hisilicon/hpre/hpre_main.c
>  
>  HISILICON HNS3 PMU DRIVER
> -M:	Guangbin Huang <huangguangbin2@huawei.com>
> +M:	Jijie Shao <shaojijie@huawei.com>
>  S:	Supported
>  F:	Documentation/admin-guide/perf/hns3-pmu.rst
>  F:	drivers/perf/hisilicon/hns3_pmu.c
> @@ -9343,7 +9343,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
>  F:	drivers/net/ethernet/hisilicon/
>  
>  HISILICON PMU DRIVER
> -M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
> +M:	Yicong Yang <yangyicong@hisilicon.com>
>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  S:	Supported
>  W:	http://www.hisilicon.com
> 
