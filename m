Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04E3785D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjHWQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbjHWQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB93D10C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83406620ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35593C433C8;
        Wed, 23 Aug 2023 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807978;
        bh=FnuarZnFAyUqPz7jr69MFRBMZfNtqK9XZFNFPqeSp+g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aK3vrOi4K8xD9Psm4va2dwSihu6CwTQJsD5ATzCRXvDmv5wpzj3RBmUxviHiW5UEN
         hG5pppSmtc7Tq6AT3ch0uVTakTZ5VKsDHakn/YR8rm627/TQ8QfL/XQ2Ko7VgKh/R3
         4j/USHgKHmbCp3v3Do1FBrHDs45SSvSyUjCtp4B/rXbOD4oclvScxe6YKVP2L8JpHy
         nRNydlkEWigrijcMe3KHurpOjS05N1c5Ttp0o4HOsH7XZyBBPvjcwy8JlaUyTPOVfs
         6Xy0Kka+Ud6U8MwmMPb6kjpVAC8qf1lb5nK26GsnZVyOye+tetQYIXCpthr0plXo6y
         uSmkMrsRmZDZg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230822-delete-l3-v2-1-b3ffc07348af@linaro.org>
References: <20230822-delete-l3-v2-1-b3ffc07348af@linaro.org>
Subject: Re: [PATCH v2] ASoC: Delete UDA134x/L3 audio codec
Message-Id: <169280797694.53791.13283678720134616535.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:16 +0100
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

On Tue, 22 Aug 2023 22:55:44 +0200, Linus Walleij wrote:
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

