Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5876E9E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjHCNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjHCNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:18:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214543C02
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:18:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qRYDe-00078u-6w; Thu, 03 Aug 2023 15:18:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qRYDd-00070f-AE; Thu, 03 Aug 2023 15:18:21 +0200
Date:   Thu, 3 Aug 2023 15:18:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] ASoC: fsl: micfil: Use dual license micfil code
Message-ID: <20230803131821.GA26314@pengutronix.de>
References: <20230803072638.640789-1-daniel.baluta@oss.nxp.com>
 <8a1f9a9a-0962-4c64-8226-b48535a0ae86@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1f9a9a-0962-4c64-8226-b48535a0ae86@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:45PM +0100, Mark Brown wrote:
> On Thu, Aug 03, 2023 at 10:26:38AM +0300, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> > 
> > We need this in order to easily reuse register definitions
> > and some functions with Sound Open Firmware driver.
> > 
> > According to Documentation/process/license-rules.rst:
> >     "Dual BSD/GPL"	The module is dual licensed under a GPL v2
> > 			variant or BSD license choice. The exact
> > 			variant of the BSD license can only be
> > 			determined via the license information
> > 			in the corresponding source files.
> > 
> > so use "Dual BSD/GPL" for license string.
> 
> Adding Sascha as he seems to have written a lot of the commits for the
> driver including some features.  Leaving the full message for his
> benefit.

I am fine with that change.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_micfil.c | 4 ++--
> >  sound/soc/fsl/fsl_micfil.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> > index fe28b27e50d0..97cf315781ab 100644
> > --- a/sound/soc/fsl/fsl_micfil.c
> > +++ b/sound/soc/fsl/fsl_micfil.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> >  // Copyright 2018 NXP
> >  
> >  #include <linux/bitfield.h>
> > @@ -1254,4 +1254,4 @@ module_platform_driver(fsl_micfil_driver);
> >  
> >  MODULE_AUTHOR("Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>");
> >  MODULE_DESCRIPTION("NXP PDM Microphone Interface (MICFIL) driver");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("Dual BSD/GPL");
> > diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
> > index 9237a1c4cb8f..fee9fe3d9119 100644
> > --- a/sound/soc/fsl/fsl_micfil.h
> > +++ b/sound/soc/fsl/fsl_micfil.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> >  /*
> >   * PDM Microphone Interface for the NXP i.MX SoC
> >   * Copyright 2018 NXP
> > -- 
> > 2.25.1
> > 



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
