Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE94675C834
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGUNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5492737
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3848461B44
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93751C433C7;
        Fri, 21 Jul 2023 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689947409;
        bh=YsQzXX3Iw4UgmsXP3jpsMX5rLlr+D3/qJOyXveoe34g=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=fwELfVEuxyxClMKPH1dG7QgyZxtfj91aX+6/L5bchj2GmldVYbN7x7mFpfswsmShj
         jXbi4PsTBDpp2UbuIDZI/xBC0sdllU5uRJFYYfCcC+285Kf3z1cdQjvK0+JqFd/Ahn
         QUvNmLq31RY5dXM2FyKlujUvMS8D0HWyU3gg1F5RQWZzJGGbXrf+GaPwDUTpRz3oHX
         OmSJSWrYyu3XEe9zKqo76zZQAUla4vtc94XOqv+nx+7EMxKS/P4y0dfZYO+8JKrm2d
         RwMtd46frJAfAzBxmGCexFAbsuVESE37SUTG/jsiXFc531gNZSygD7T2dRc2BWJcmC
         N+p9pM/GFhmlQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1689927842-21165-1-git-send-email-shengjiu.wang@nxp.com>
References: <1689927842-21165-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8960: Add DAC filter characteristics
 selection
Message-Id: <168994740616.98802.14306640760170381648.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 14:50:06 +0100
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

On Fri, 21 Jul 2023 16:24:02 +0800, Shengjiu Wang wrote:
> Support DAC filter characteristics selection: Normal mode
> and Sloping stopband. Sloping stopband may have
> better frequency response.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Add DAC filter characteristics selection
      commit: 8cf2e3b1961e59dabc75e9e917d58439164a8f84

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

