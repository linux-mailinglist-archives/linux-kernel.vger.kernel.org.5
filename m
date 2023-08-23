Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF185785D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjHWQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjHWQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197B10F1;
        Wed, 23 Aug 2023 09:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDEF646FD;
        Wed, 23 Aug 2023 16:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E06AC433C7;
        Wed, 23 Aug 2023 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807983;
        bh=qECGWHKOobEzMxHuX8r68lcnknGzvl9J0XZxy3E5EV0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bf/8ucgpTSoUFaso5roJFNIgYAH9KpnXiC/ZNs3wi/AINC54uiHRcPnH3fEX15bsy
         b2XFJU1S4tBOH2VMg9e7De3DEA+/F0k0G9dpIuiOVnm3nL0sdDhWvsernsld5x2OzQ
         xGz5qnvBRUxORlLczRKYtEW6PIqtGMnhKgZPbFnFvZYzHDL2Kx9C0NKoZYAdFHbJEl
         R8J8gth3skepTKFP6NSRfysIsi7iG9/3y57DcbCcBHbRPdgLvbMcoS2kHvIDNB/JL6
         A/W+PxjF6PbbBKUUw7+qAGyo6R3uAU/HYjXGBfB8jc+5wJ0cpbox4RRd/Gf1PHhjU1
         yWz6v1M9Bj86w==
From:   Mark Brown <broonie@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
In-Reply-To: <20230823071244.1861487-1-wtli@nuvoton.com>
References: <20230823071244.1861487-1-wtli@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add single-ended input
 feature
Message-Id: <169280798077.53791.13745062802650648258.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:20 +0100
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

On Wed, 23 Aug 2023 15:12:43 +0800, Seven Lee wrote:
> Add input with single-ended control.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nau8821: Add single-ended input feature
      commit: 91e28d0b51f994c5968aee2a941e9f62bc9e15d7
[2/2] ASoC: nau8821: Improve AMIC recording performance.
      commit: 014ee0692f29da8b08fed5da0fa14e04698a50f7

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

