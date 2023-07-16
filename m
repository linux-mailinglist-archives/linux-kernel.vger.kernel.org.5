Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A8754EA2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGPMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 08:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED709E57
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 05:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2551B6027E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F05AC433C7;
        Sun, 16 Jul 2023 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689511883;
        bh=qQluAUUph6dF5He95iJDv4ieY+bdVsSmL6RVQ7lj5tc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t0IAKjqNq47RRobIBj6/Zax5qws7wyeI5aUjJM6CAMvHFEVjvEpddgen5QvmAwZtk
         ZUhb42B14BHFb0Xm1lLWOkzjcRUEPeHLHfLvgV1reg9M/RUQgPsu94/2vodeVHAxo9
         9kkT0j5wgbGMhj30HZvydkny5erHXNVJa1praUoAcvkwu0GTK3zz27XsGPk1VWo/T6
         gwdliXaw2zQ+CQv+a9GZavxmhnk3S3uOtKxE7Y9s76VrNsAq56oKCZRZDnnnaOQt8O
         7Sm4QyI19ioJgS5U+CajNRj1xTRdduXiaaj9S768BfcJaZMIjXnPgxH7KJSs61a4On
         FH4ZTLUJRuyUA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     asahi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230712121556.93500-1-povik+lin@cutebit.org>
References: <20230712121556.93500-1-povik+lin@cutebit.org>
Subject: Re: [PATCH] MAINTAINERS: Redo addition of ssm3515 to APPLE SOUND
Message-Id: <168951188236.111741.1672794813094209175.b4-ty@kernel.org>
Date:   Sun, 16 Jul 2023 13:51:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 14:15:56 +0200, Martin Povišer wrote:
> The MAINTAINERS entries added in commit 4ac690bbae02 ("ASoC: ssm3515:
> Add new amp driver") were later erased in a merge commit. Re-add those.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Redo addition of ssm3515 to APPLE SOUND
      commit: e8bf1741c14eb8e4a4e1364d45aeeab66660ab9b

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

