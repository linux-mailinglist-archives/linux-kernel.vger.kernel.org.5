Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3A79C25D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjILCJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbjILCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6B1A5316
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9376C32779;
        Mon, 11 Sep 2023 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476662;
        bh=DgTYRQBSoJwFvdOE21aqdGWssFdi96AaqXB7ox6Gvl8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sCsbC+kBVOnYpheOEgpvIQenH7Rc5ejskACNLgOFadmXomrRduMQWUqt747gbZEYn
         DJWD9sn8SQpvwnUc5i4Er6yDrW0g/ekW5W/18qnu6473W9xqN8DJ27U0VgvRRvaoeb
         z/GXRQYMe8bwrZ2zkCFgV6g2pvNY3MluE9cr97p4/2BpIx4VQgRu9Q//+PChIVK7dU
         ewEQjQgO2jiYrE/FmbTpFfinrqanrbUgcneOk6iBk53977A06j109yuNWsG9ctKUdY
         +Hoet91nTSOyQ7Pq/zKpGAFXddjr3wD2u4CUurCxwTylM7HYRd/alkV9cAKR47ST8u
         SB7Rb7xiu+/rw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230825024935.10878-1-trevor.wu@mediatek.com>
References: <20230825024935.10878-1-trevor.wu@mediatek.com>
Subject: Re: [RESEND,v3 0/3] ASoC: mt8188-mt6359: add SOF support
Message-Id: <169447666040.2387538.8880759925016184457.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 10:49:32 +0800, Trevor Wu wrote:
> This series introduces dynamic pinctrl and adds support for the SOF on
> the mt8188-mt6359 machine driver.
> 
> Changes since v2:
>   - revise mtk_sof_check_tplg_be_dai_link_fixup().
> 
> Changes since v1:
>   - minor changes to incorporate the suggestions from the reviewer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mediatek: mt8188-mt6359: support dynamic pinctrl
      commit: d601bb78f06b9e3cbb52e6b87b88add9920a11b6
[2/3] ASoC: mediatek: common: revise SOF common code
      commit: 4047b35c836ff9f8bf1f57c4ab871136899267e9
[3/3] ASoC: mediatek: mt8188-mt6359: add SOF support
      commit: 1bce95deab841ece9602f941e68c7b919fde303d

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

