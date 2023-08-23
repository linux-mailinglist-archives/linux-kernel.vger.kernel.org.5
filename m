Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B700D785264
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjHWILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjHWIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:08:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EBFE5C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RVzHg3jg0z6K638;
        Wed, 23 Aug 2023 16:03:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 09:08:08 +0100
Date:   Wed, 23 Aug 2023 09:08:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>, <yangyicong@huawei.com>,
        <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <hejunhao3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: Update email
 addresses of HISILICON_PMU driver maintainers.
Message-ID: <20230823090811.00001f7f@Huawei.com>
In-Reply-To: <20230822122812.2384393-1-shaojijie@huawei.com>
References: <20230822122812.2384393-1-shaojijie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 20:28:12 +0800
Jijie Shao <shaojijie@huawei.com> wrote:

> Since Guangbin and Shaokun have left HiSilicon and will no longer
> maintain the drivers, update the maintainer information and
> thanks for their work.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Best wishes and thanks to them both and thanks to yangyicong and
shaojijie for stepping up.


Bit late now, but with hindsight it might have been better
to use the same wording for the HNS3 PMU as for HNS itself

HISILICON NETWORK SUBSYSTEM 3 PMU Driver (HNS3 PMU)
so that it would appear in the obviously place in MAINTAINERS
rather than a few lines further up.  Probably not worth
the noise of changing it however.

Jonathan


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

