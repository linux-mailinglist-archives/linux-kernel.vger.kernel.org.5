Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5367EC063
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjKOKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:25:51 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D6C12A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:25:47 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AF8RKgq026572;
        Wed, 15 Nov 2023 04:25:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=WU5nZyJTrXQvRiyk3lOymBc4LYlI1sgiF28uWIkTirM=; b=
        fcJoEjzLBcQMRe4moUkamR7m0tXtlYT0/Wil5LaBXNxAfIYnJFDSjRw/O0EerTxt
        0W3t9sIobZh/L8mujHuIZ5wSD0uoPOFA14kILnjnflOTtjbDGJgVhkz5TrVQWk7z
        Eb50s4oNtdIbdPHeZryazf2J7pq4glW7g8ooOlI0aNEQndzo1MSCTpVLraaOzgtO
        XqwBM/UOZ6E6IYjsbnHWrIO+EE89VGhpBhdoou6JMfqUbbEgoIW8fj/bbJLcGmY8
        zplycEsQWLJSHVEEgI1aiemSy76fZKLlMphtxpilno5QeU+S6IfBW4e+4KtRlTGr
        x51Phbq/UPhg5T++YZ4GeA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpch3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 04:25:39 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 10:25:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 15 Nov 2023 10:25:37 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7851915A1;
        Wed, 15 Nov 2023 10:25:37 +0000 (UTC)
Date:   Wed, 15 Nov 2023 10:25:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
Message-ID: <20231115102537.GB32655@ediswmail.ad.cirrus.com>
References: <202311071303.JJMAOjy4-lkp@intel.com>
 <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
 <20231115093742.GA32655@ediswmail.ad.cirrus.com>
 <CACRpkdYHJcx8gDsa5P2eLBh6iaVQzZY+-4eMJPKtnQTq3uR6oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYHJcx8gDsa5P2eLBh6iaVQzZY+-4eMJPKtnQTq3uR6oQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: rOqXo6meEJM6lTSU5Tw9mjRheaugKhQM
X-Proofpoint-ORIG-GUID: rOqXo6meEJM6lTSU5Tw9mjRheaugKhQM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:57:29AM +0100, Linus Walleij wrote:
> On Wed, Nov 15, 2023 at 10:37 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Tue, Nov 14, 2023 at 02:40:38PM +0100, Linus Walleij wrote:
> > > On Tue, Nov 7, 2023 at 6:19 AM kernel test robot <lkp@intel.com> wrote:
> > It has somewhat been on my radar to fix at some point, but I have
> > in general been a little unsure how to proceed. RST feels like
> > a mega over generic macro name to be exporting, so in some ways
> > feels like fixing that would be nice. On the other side, renaming
> > the register on the Lochnagar side would be very easy, although it
> > would mean the register naming no longer matches all the hardware
> > documentation which would be kinda lame.
> 
> If MIPS breaks things like this because of weird defines I would say
> it is actually fair to just quirk it in Kconfig with a comment:
> 
>   # MIPS occupy very generic defines
>   depends on !MIPS
> 

Hm... hadn't considered that. The driver is pretty unlikely to be
needed on MIPS anytime soon, so might be a reasonable work around
for now. Would you like me to fire in a patch, or you want to?

Thanks,
Charles
