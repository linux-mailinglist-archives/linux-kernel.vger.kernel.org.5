Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DEE754EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGPMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGPMv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 08:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CF90
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 05:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00AE60C96
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A32C433C8;
        Sun, 16 Jul 2023 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689511885;
        bh=NT/Q09rhluS8L9Ka3lzCZxUHc07k1JJlwspZfH06+ow=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fALiWLEur/R/dICF3VxalAXgliFRc6IhELI71dYX6C01Q5KbczJFHPYzhLa8DrsRn
         M5aEr7p1QGLbqFh2weD8gg7nB5wO+sUJWT3LxBi1msWwcpu97H2kKSi5kzB5oCl6xE
         0Jw3m7nXysmaYtcnuUpK1bLHpenbCYgmgv/WSRTtJef5IPEk+M+buWFmtULkPG7Va2
         cV1Q43/6k54KAuu5mmJeTzbnFz/gPkmpVDdb333pZIjR/D/13YFPnllhJfWfUA0mIr
         o5JouRSXgZZuNdlwRwccC3LnvMe8q/r7dqLjsOyVR7bqpfBbG3VnWu7DGKOLH1Ceu7
         nLgnpGf3Oj4pg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230713065106.21564-1-yang.lee@linux.alibaba.com>
References: <20230713065106.21564-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: amd: acp: clean up some inconsistent
 indentings
Message-Id: <168951188373.111741.18081933032544174557.b4-ty@kernel.org>
Date:   Sun, 16 Jul 2023 13:51:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 14:51:06 +0800, Yang Li wrote:
> sound/soc/amd/acp/acp-rembrandt.c:283 rmb_pcm_resume() warn: inconsistent indenting
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: clean up some inconsistent indentings
      commit: 6d2a87ddd9c2488732ca422476a9417ca312f75a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

