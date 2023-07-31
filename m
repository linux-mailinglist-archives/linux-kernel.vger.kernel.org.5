Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5614769BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGaQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjGaQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF911B;
        Mon, 31 Jul 2023 09:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C71E61207;
        Mon, 31 Jul 2023 16:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E6EC433C8;
        Mon, 31 Jul 2023 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690819254;
        bh=/dCet8XmUJipf8WggPxSXVgBhmmfgN+TAydOUhSvMGQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d1zxR5Mk+D5JLrut+8x9jS2F0dxofTZYmGLjEVxMUxurvldI48m3ju9cwhR2ztJiA
         OT98uB6vyNPpc0+qwEErShKAu49ggw9FqFqYMbDWf1CNXOEJGIflB9dadlzHJ8huI8
         tidJgVGkVuT1kh23OaO3aCQsXM4M9JFZ7wI3wbYbGL2Zw+B90CV4cwFT2r/rFELzzq
         KtLzXv+1ZJUIcLfg4QqRXyBiXIavJAwjD7nOGafJRoy+DQ3rHtFTv/hSynSr51cilc
         ejVha9g2kcDonh0+4tRkQZDNa+8aDVZl26nS2VSE1I8HFAmYWgbpSyQW/VVu/QkhaD
         ufbxqt6tGMqOw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>,
        David Heidelberg <david@ixit.cz>
Cc:     =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230730191742.117013-1-david@ixit.cz>
References: <20230730191742.117013-1-david@ixit.cz>
Subject: Re: [PATCH v4] dt-bindings: sound: gtm601: convert to YAML
Message-Id: <169081925251.69703.15494857199278505179.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 17:00:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 22:17:42 +0300, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: gtm601: convert to YAML
      commit: cd8ee8aba1f3b5dd4118dc8cea05b73734983288

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

