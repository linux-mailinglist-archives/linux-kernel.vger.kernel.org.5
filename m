Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEB7884DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbjHYKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244544AbjHYKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896F2116
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E9E61CD3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD85C433C7;
        Fri, 25 Aug 2023 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692959133;
        bh=vxCQvJwwZuY+Os//P83VMfDGNLl1duuxq7unTJHC1bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2onVQDkXoebNOsXBLTxey6UseN5/XAkEEqS2agypZkch2PisVrtj1j0GMV4cBMth
         FF7BPS1TS59+3Qb03cP3/8gkvieYYlOurdegg3jBK+M5qUp8YMAn2sxMP6UN0kk3PZ
         bLUkeGCWeyuG5AsQ/vAY5KElxyFXBx3/gOlYoFcloIMXnMzJkX6i7FaTF8r6I/LgDx
         unSs/QCjBXId8o6eXdhLphvgIkNlPhzzggSkkrcfsV3Jb5PYx6ubWesoRO41UI+tyt
         4T1vfL8/6vcciYr2nlT9VZNYQCRRdPUMPv4DTydsLYXJU7KruGcqJgoC/atvIyLFfJ
         +jHhjHM1o2gfw==
Date:   Fri, 25 Aug 2023 11:25:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Zenghui Yu <zenghui.yu@linux.dev>
Cc:     Jijie Shao <shaojijie@huawei.com>, jonathan.cameron@huawei.com,
        mark.rutland@arm.com, yangyicong@hisilicon.com,
        chenhao418@huawei.com, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: Update
 HiSilicon PMU maintainers
Message-ID: <20230825102522.GA24076@willie-the-truck>
References: <20230824024135.1291459-1-shaojijie@huawei.com>
 <9009693a-0314-9526-e57f-1b2302abfd7e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9009693a-0314-9526-e57f-1b2302abfd7e@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:07:32AM +0800, Zenghui Yu wrote:
> On 2023/8/24 10:41, Jijie Shao wrote:
> > Since Guangbin and Shaokun have left HiSilicon and will no longer
> > maintain the drivers, update the maintainer information and
> > thanks for their work.
> > 
> > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  changeLog
> >  v2:
> >   1. update "HISILICON HNS3 PMU DRIVER" to "HISILICON NETWORK SUBSYSTEM 3 PMU DRIVER"
> >      suggested by Jonathan
> >   2. update pach subject suggested by Yicong
> >  v1: https://lore.kernel.org/all/20230822122812.2384393-1-shaojijie@huawei.com/
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4171d3a102a9..df3418780b0c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9304,8 +9304,8 @@ F:	drivers/crypto/hisilicon/hpre/hpre.h
> >  F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
> >  F:	drivers/crypto/hisilicon/hpre/hpre_main.c
> > -HISILICON HNS3 PMU DRIVER
> > -M:	Guangbin Huang <huangguangbin2@huawei.com>
> > +HISILICON NETWORK SUBSYSTEM 3 PMU DRIVER (HNS3 PMU)
> > +M:	Jijie Shao <shaojijie@huawei.com>
> >  S:	Supported
> >  F:	Documentation/admin-guide/perf/hns3-pmu.rst
> >  F:	drivers/perf/hisilicon/hns3_pmu.c
> 
> You probably need to move the entry around to keep things ordered
> (see commit 80e62bc8487b).

I'll just leave the title of the entry as it is to avoid the churn.

Will
