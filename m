Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8397E05CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjKCPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjKCPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:55:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DDB111;
        Fri,  3 Nov 2023 08:55:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AE3C433C7;
        Fri,  3 Nov 2023 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699026954;
        bh=tmLWY+L7FwVUJMV6C2Akc2299XINHfV2Cbm+4LEhXJA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UBBdKHl15srI8XZ+TxU7EqftZIy+5H1Wz5rFrYPoIkFIfPnFiMwZ558WldaixuC2c
         kIr8KmQK2rkk/uOdaaoVi/NnJQm55Gt+2kHaRnaKBWBsrTaY9rE794g3AUldDY+7hC
         iJ64x4QuphHo5VRMoxOilJ1tbQF7+HCFl4X9fTbtW1GHkbJxrFu40e84C4p5k+fZB1
         jmMG8PYS6gr3mmJssigqdF+FBt3L86l5v2hRAim8raW91adfPcGCU1QUUYIUoUoiib
         og0SRGZLOtzFKQR72YCxjnJ11KuIDByLmG8u9dCjoOgMTez7AYNGaImvQO6HTTUqZY
         1kqgkLOTcJnzw==
From:   Mark Brown <broonie@kernel.org>
To:     jiaxin.yu@mediatek.com, linux-sound@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20231031103139.77395-1-eugen.hristev@collabora.com>
References: <20231031103139.77395-1-eugen.hristev@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial:
 fix error messages
Message-Id: <169902695274.54161.7134802651266930542.b4-ty@kernel.org>
Date:   Fri, 03 Nov 2023 15:55:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 12:31:39 +0200, Eugen Hristev wrote:
> Property 'playback-codecs' is referenced as 'speaker-codec' in the error
> message, and this can lead to confusion.
> Correct the error message such that the correct property name is
> referenced.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages
      commit: 004fc58edea6f00db9ad07b40b882e8d976f7a54

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

