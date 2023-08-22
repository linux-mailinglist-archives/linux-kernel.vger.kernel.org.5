Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4997847B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbjHVQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjHVQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113BE56
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2760F65CB2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C34BC433C9;
        Tue, 22 Aug 2023 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722003;
        bh=87Mt00iuVTM5oBM4ntFY2pK6S9pr01eqEEsQVkUzh8E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nuh5uCsDO9R/DtXYTMX63zubV2lzP8jnU3eOXWGXARVvhis3XHzGU9x7HtJ4HTKQz
         s8QDSv9q0d/jFxuY33aTr8+ya3Fes5dCMNaJxa7h/2oeTAR55HdjzkVUNurXWHuqxn
         iQoGQNR+WOeszWXaJ4oQPStBGK22d3ZT//ugbZLS5/aaO35nqxJqCVPxYithan4bf3
         rdChqRb414U0Hw5GU1pgmi1pTDUjdyEiTvY5DoFmKck7bIJ1owK4FKF+Ws38+GLFB5
         F6omuXur0HQFYGVDP33l9Pe95XlTdcUurY65JIwp6CQRJJ14RuxJghyJp7H03H20sM
         +dS9bv1VYmofg==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com,
        Senhong Liu <liusenhong2022@email.szu.edu.cn>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230819133345.39961-1-liusenhong2022@email.szu.edu.cn>
References: <20230819133345.39961-1-liusenhong2022@email.szu.edu.cn>
Subject: Re: [PATCH] sound/soc/codecs/rt5640.c: fix typos
Message-Id: <169272200183.71502.12839834978316716379.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 06:33:45 -0700, Senhong Liu wrote:
> I noticed typos and i fixed them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound/soc/codecs/rt5640.c: fix typos
      commit: 8e6657159131f90b746572f6a5bd622b3ccac82d

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

