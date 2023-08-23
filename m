Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F83785D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjHWQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHWQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D654E7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D0C620ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7CC433CA;
        Wed, 23 Aug 2023 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807976;
        bh=MjJ78APs4nHACIMIv6Eznanwwx/xp3HSffo39PEGkLc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=naClsm80YD7oHCWwv1RWWUoEU9YM9rlrMQY8UOwMqM7wPbnCqSP9qGwq056tWdymk
         8t4uMB1gcqjD87X2cJQeSpXIz/6tOVKVrNHrxmnZsAyCEe8gPaD7k28Y4QbtQ/NDch
         YOVepeLHur/3iHdPjGVuIyprai0wl2T+QWqMsT1eChkAwDTrltdJ8N2l9vtpJf80Gl
         BHCIln2RMs/G877RCJTvewgQvuvWrGIih3QwkwhR7ej8+fyreXayBqIdBPz7i6WLYl
         rZ6spsxHNETyfJSM2XS28TkIfkNkNgdNkDVZhWQxXxfdwtngt66OTFcVvuaYsW/+1g
         ZzONVi9IuDgoQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230821-delete-l3-v1-1-26d9cd32e7a2@linaro.org>
References: <20230821-delete-l3-v1-1-26d9cd32e7a2@linaro.org>
Subject: Re: [PATCH] ASoC: Delete UDA134x/L3 audio codec
Message-Id: <169280797490.53791.2553554158977527260.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 16:17:57 +0200, Linus Walleij wrote:
> This codec was used by the deleted S3C board
> sound/soc/samsung/s3c24xx_uda134x.c.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Delete UDA134x/L3 audio codec
      commit: 6dd11b945951315ba4986844f20e83a0c27c1d38

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

