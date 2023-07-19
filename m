Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA6758C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGSE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGSE3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:29:48 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D16291B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:29:45 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1455446:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 19 Jul 2023 12:29:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 19 Jul
 2023 12:29:37 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 19 Jul 2023 12:29:37 +0800
Date:   Wed, 19 Jul 2023 12:29:37 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>
Subject: Re: [PATCH v2 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC
 driver
Message-ID: <20230719042937.GA29368@linuxcarl2.richtek.com>
References: <cover.1688569987.git.alina_yu@richtek.com>
 <5fc248e0b2c4d3f59c2af3ec89cc333c8acbc372.1688569987.git.alina_yu@richtek.com>
 <20230718084028.GA24273@linuxcarl2.richtek.com>
 <0b956726-f96f-479a-85d1-80b315626a18@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b956726-f96f-479a-85d1-80b315626a18@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Mark

On Tue, Jul 18, 2023 at 03:16:54PM +0100, Mark Brown wrote:
> On Tue, Jul 18, 2023 at 04:40:28PM +0800, Alina Yu wrote:
> 
> > Sorry, not intend to ping, just want to check the current review status.
> > Is there any comment about rtq2208-regulator.c
> 
> It's not in my queue any more so probably no but I really don't
> remember, I guess there was some issue with the DT binding that I was
> expecting a respin for.


Thanks you for your reply,
I send v3 which including modification for dt-binging.


Best regards,
Alina

