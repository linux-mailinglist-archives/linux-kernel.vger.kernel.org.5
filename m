Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2837FDFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjK2SxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjK2Sw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:52:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8519F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:53:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C33FC433C9;
        Wed, 29 Nov 2023 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701283984;
        bh=+VD6UkfC+iyI0rWTVDs/Yc0qsEfofTjJTPu75VnwKEo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gSNOqpD41Bn6l1qlcftUsRAsAHI080qqo8imWX7vdQMoItgb2h0kq5LgXBN51hr9Q
         oLtwSPXoPuTN2euP4eLtQoDRPn93Vgjbsqaw81IegJbC3HJWcZOQyJuwKkkHV3PN0h
         AeCjsBA09oh91XBwcHXBrpJVTIEeyoIQ6reKOA5z+3o5dBqKF9cRP9p0Azu0CQh24A
         bQO7uDjv3t197dENpiD5s3q4fEQHvQKtDKyob3YOUsqHl5Ew2O7vkMlu2TQj8rQNwA
         zEGj5OvFXQ/xISNDwK7jcyTc7liYIbGAqfYyN9AaLSkHYdVL3XSnOG+5N3pU7SSaFV
         gNATZovnJE6JQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231129090958.815775-1-colin.i.king@gmail.com>
References: <20231129090958.815775-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: core: Fix a handful of spelling mistakes.
Message-Id: <170128398283.290371.17199524750105077840.b4-ty@kernel.org>
Date:   Wed, 29 Nov 2023 18:53:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 09:09:58 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message and several
> spelling mistakes in comments. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Fix a handful of spelling mistakes.
      commit: e9a92dfc8d4fde6f7adb978fb13d0b0834567cc5

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

