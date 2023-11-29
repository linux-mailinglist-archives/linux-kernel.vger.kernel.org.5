Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591A37FD600
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjK2Lt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjK2Lt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:49:57 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65AD66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:50:02 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8J4q-0006jj-Ae; Wed, 29 Nov 2023 12:50:00 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/7] reset: brcmstb: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <170125859891.1536325.610937026047851178.b4-ty@pengutronix.de>
Date:   Wed, 29 Nov 2023 12:49:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 20:02:05 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied to reset/next, thanks!

[1/7] reset: brcmstb: Use devm_platform_get_and_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=1750ec405933
[2/7] reset: meson-audio-arb: Convert to devm_platform_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=66a1f3929a52
[3/7] reset: qcom-aoss: Convert to devm_platform_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3d471cfbf26c
[4/7] reset: qcom: Convert to devm_platform_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=49994d704d39
[5/7] reset: simple: Convert to devm_platform_get_and_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=ac53e621d802
[6/7] reset: sunplus: Use devm_platform_get_and_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=5d587019fcca
[7/7] reset: uniphier-glue: Use devm_platform_get_and_ioremap_resource()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=c64548122968

regards
Philipp

