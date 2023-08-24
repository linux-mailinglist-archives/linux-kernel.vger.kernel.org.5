Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584B787507
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbjHXQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbjHXQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:15:34 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 09:15:31 PDT
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B3D19A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:15:31 -0700 (PDT)
Message-ID: <9009693a-0314-9526-e57f-1b2302abfd7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692893302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5E7qdRr6tib71iljQtViXUKA8jJHdS410Eq+tt1g2I=;
        b=Etu8MOjjsSuYy+D+Sca7uQL7uibHzazb//dIfY11wSUjJP6lhA9yTPQS47Cn4tPlBpwoko
        rbQPcfq3PHGdgi0+L6K0hlG4mkXx0DuUZ6FybsAhQvBUusF2aStcd4bgUgaB0gOKYhxdua
        gLVqYX++NV2vypi5O50Y5m4C8lnK42g=
Date:   Fri, 25 Aug 2023 00:07:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: Update
 HiSilicon PMU maintainers
Content-Language: en-US
To:     Jijie Shao <shaojijie@huawei.com>, will@kernel.org,
        jonathan.cameron@huawei.com, mark.rutland@arm.com,
        yangyicong@hisilicon.com
Cc:     chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230824024135.1291459-1-shaojijie@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20230824024135.1291459-1-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/24 10:41, Jijie Shao wrote:
> Since Guangbin and Shaokun have left HiSilicon and will no longer
> maintain the drivers, update the maintainer information and
> thanks for their work.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  changeLog
>  v2:
>   1. update "HISILICON HNS3 PMU DRIVER" to "HISILICON NETWORK SUBSYSTEM 3 PMU DRIVER"
>      suggested by Jonathan
>   2. update pach subject suggested by Yicong
>  v1: https://lore.kernel.org/all/20230822122812.2384393-1-shaojijie@huawei.com/
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4171d3a102a9..df3418780b0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9304,8 +9304,8 @@ F:	drivers/crypto/hisilicon/hpre/hpre.h
>  F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
>  F:	drivers/crypto/hisilicon/hpre/hpre_main.c
>  
> -HISILICON HNS3 PMU DRIVER
> -M:	Guangbin Huang <huangguangbin2@huawei.com>
> +HISILICON NETWORK SUBSYSTEM 3 PMU DRIVER (HNS3 PMU)
> +M:	Jijie Shao <shaojijie@huawei.com>
>  S:	Supported
>  F:	Documentation/admin-guide/perf/hns3-pmu.rst
>  F:	drivers/perf/hisilicon/hns3_pmu.c

You probably need to move the entry around to keep things ordered
(see commit 80e62bc8487b).

Zenghui
