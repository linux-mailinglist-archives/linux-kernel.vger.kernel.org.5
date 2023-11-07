Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838927E4162
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKGOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKGOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:02:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD0A2;
        Tue,  7 Nov 2023 06:02:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B83C433C7;
        Tue,  7 Nov 2023 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699365734;
        bh=+6mQ9bbmmseHzj3M7Iyp2LgNn/cHwP0SDYVcmlkDjb0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hHiKmgl5mTJ4LtNITG0baiIuAc7p+GZ9OlqWZF1YD+T2rao5yLMTOvoaTC4QWJp3+
         S6ejkps8uYkLTOZbM3q+elPbgP2RJJQpJW2dxTNJNQ60wGf+l9cjZJcbPcrWLLtoSI
         HWCfAa3/IyJ0fQDWDBOKCwBf1ZLpHhMVL5iQ+ZqoUQF2HxnbL6FmeK7LTvcbpw6DzN
         sbNHPDtHjObWM2DGB3fK66ev6oNVhZq9br1tZNEjPAcFIFUmCoA1gXUikegNUr7hu3
         8Q6IkqHu2sFoGFPyzEYWNxJ19NGjZ2D5k4LIDzwAeVntIXFDAbgBVAk9bvyMo6UgKR
         x0q+EJ6lZEplg==
From:   Mark Brown <broonie@kernel.org>
To:     sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20231031112218.79136-1-eugen.hristev@collabora.com>
References: <20231031112218.79136-1-eugen.hristev@collabora.com>
Subject: Re: [PATCH] ASoC: SOF: sof-client: trivial: fix comment typo
Message-Id: <169936573326.3097787.14702265227428637348.b4-ty@kernel.org>
Date:   Tue, 07 Nov 2023 14:02:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 13:22:18 +0200, Eugen Hristev wrote:
> Fix typo s/depndent/dependent
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-client: trivial: fix comment typo
      commit: 45f2f28bd498fb697d07a38775d55f0f50fee5ca

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

