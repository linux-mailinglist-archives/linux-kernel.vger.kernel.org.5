Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CED7EBF98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjKOJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:38:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281CE5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:38:01 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AF6u5ua002185;
        Wed, 15 Nov 2023 03:37:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=
        PODMain02222019; bh=wA83epg46IZxAyewUV28Kirt+0qSsu7iAQen/Bkb5aY=; b=
        dXLcemkpsj1/UAK2CyrriXw6ZgBELDmsR9lGpAAMoccixZjRyqc1gnjO+XST9tGw
        mYEx8hjBz/dHDeYKtqflSo3nXORfeO0clhxvgQizGsVQVCJHLOu1I0NyFg3edovJ
        9xVGSasZVKOXqkAkUK2XAmSPYIQFZflXGNOykqvLD99EX6AO7qC7v61QkbAbNMll
        t5KJNinb2h4b86R3y3RJDlNzXm3NvNDBXVFo6b71RwXZFgWfGSEbAZu+R7mBF27r
        C6Zep1pWw2+dRoOBRgZqo7+M6edaaghDB6He5iHKta0Kshq+iVxjrlf0O+ZUThKE
        d/1BhiMzh47wxlpYdb88fg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpcfp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:37:43 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 09:37:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 15 Nov 2023 09:37:42 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 16FB915A1;
        Wed, 15 Nov 2023 09:37:42 +0000 (UTC)
Date:   Wed, 15 Nov 2023 09:37:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
Message-ID: <20231115093742.GA32655@ediswmail.ad.cirrus.com>
References: <202311071303.JJMAOjy4-lkp@intel.com>
 <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ib5uJw7pb3N9TXitRPyqY-5-0thUbsl9
X-Proofpoint-ORIG-GUID: ib5uJw7pb3N9TXitRPyqY-5-0thUbsl9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 02:40:38PM +0100, Linus Walleij wrote:
> On Tue, Nov 7, 2023 at 6:19 AM kernel test robot <lkp@intel.com> wrote:
> 
> > >> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
> >       52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
> >          |                                                     ^~~~~~~~~
> >    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
> >       67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
> >          |         ^~~~~~~~~~~
> 
> I looked a bit at this, can this be due to the fact that the macros use defines
> from include/dt-bindings/...* and that MIPS does not use these includes
> somehow, such as not using the same dtc compiler?
> 
> Rob, do you know the story of how MIPS interoperates with <dt-bindings/*>?
> 

Is that what is going on here? I though this was the long standing
problem that MIPS has some global define for RST so the macro that
string pastes that in, no longer pastes in the letters RST but some
value instead.

It has somewhat been on my radar to fix at some point, but I have
in general been a little unsure how to proceed. RST feels like
a mega over generic macro name to be exporting, so in some ways
feels like fixing that would be nice. On the other side, renaming
the register on the Lochnagar side would be very easy, although it
would mean the register naming no longer matches all the hardware
documentation which would be kinda lame.

Thanks,
Charles
