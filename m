Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3579C23F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjILCIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjILCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE81A4BD6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F3FC3277C;
        Mon, 11 Sep 2023 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476670;
        bh=9OtbIZUFBDxgyKkdw+GLmc+PCE/ZFLEZDyNbZabaVqM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vMKpS6+Pu8B/ZHOewr5w0gXcJNEhTABbIJE36iU/vzxR70DAj8UEZEIyiLzFXfMMa
         uXy6G/31UvvxAB/XaimBtjUbH/FO07qD8KUOwBsO2V9fzqA/7J/fMD0z9OEJjPoqFN
         Ql8bSzf45eVy6ptY+N6Ynr96CPWFFA60aP4xu2THa24ZAdevpYXdZiwcW4V+BKeTTA
         /1Mgs2zO2oMB5C/Aj0pQqz2/mkwwGdy87WQFOUia/GeqRH+A6JJH8N9VhebU+jyV0I
         RHqgWCIZ8k9MAGvolokKzzmQvEv4Gqywq7T0sYHGZDopn9pCyIRp4vYWdEk+eMv3IQ
         uwODw1UhMeQFg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20230907090910.13546-1-jbrunet@baylibre.com>
References: <20230907090910.13546-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg: extend TDM maximum sample rate to
 384kHz
Message-Id: <169447666857.2387538.11157727345218045709.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 11:09:10 +0200, Jerome Brunet wrote:
> The TDM HW on the axg SoC families and derivatives actually supports
> 384kHz sampling rate.
> 
> Update the fifo and tdm interface constraints accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg: extend TDM maximum sample rate to 384kHz
      commit: 43f2d432e47ebf2d7518fdef50d7cc70da376b0e

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

