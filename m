Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784879D92E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbjILSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjILSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:53:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876C106
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:53:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660CFC433C7;
        Tue, 12 Sep 2023 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544789;
        bh=7MUq8/zS0lZW+nEEmgC8UGtZYVq2UVtIY1fCP08zF1k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gr2D0K7T8Ah8zeTZFXKBRtRSDemppyMi7tKzRrot7hIhqS/HllSUboy8AmVcPV1Bu
         9V4iY/Sr0vxyI7b0tFGH+Bb5DLngorwV1rjpEKS4IsfB0BF0+bA9XJ9rZDwDOjXd9a
         EctnUT/wvMIGZ7TEJlqqbz73irC++WwQKT9KaPCnDDcDrSg6e1aOpaaA+Rqu1L2zYE
         EIgMOWy0v7btsQ9mQQCMVRzxSJq6luTgeR7N/zMFX2d1NR7QLUbNoBJy6Jw+viUkAJ
         g6mYIyzVRtVeu2f/xzqfg1LWfMIv1uqOJ5Wip3lhNs19t5btE3dQUEIu67TNYKv53h
         nHayiMN9WZPJg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230911-descriptors-regulator-v2-1-ce978c52c557@linaro.org>
References: <20230911-descriptors-regulator-v2-1-ce978c52c557@linaro.org>
Subject: Re: [PATCH v2] regulator: rk808: Drop useless headers
Message-Id: <169454478750.2416158.4313680333903939706.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 19:53:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 10:27:58 +0200, Linus Walleij wrote:
> The RK808 is already using the proper <linux/gpio/consumer.h>
> header and includes the legacy headers <linux/gpio.h> and
> <linux/of_gpio.h> for no reason, drop the includes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rk808: Drop useless headers
      commit: dd35a4debcf917f069e83f60b6ac84b5cad6e5e3

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

