Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D1805B65
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbjLEPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbjLEPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:41:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E2BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:41:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24464C433C7;
        Tue,  5 Dec 2023 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701790876;
        bh=vjrlfMihEwbG4vZyrXSqd2uLeidXw1bqUTeh6X6XMdA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gk4Blx2pzponzHlpb6XMYi385hWWRglOstEEcWEC7P5Vy9bkm+E0bb8MbxMv7EkgY
         UvZW7nRXYh7/ELJlu5aFBKhXv8HQ8lad7Rh/YHSCUGEb5lnAZpa7lePSvlLSy0Nts7
         M6v6ONHiwr5ZK86lP+oAr4mfBMZAJxBHGmBVfWyHd3JMj7/9PizhkvPKCTuSOmFYCh
         h04zydOhe7OAfpbG4sO57yml8m6wuK60lkzht9dZr414oSArn3IGoMfWN0HsR6FUDO
         hGpKXGk5qOCycNn0dXTC69W0fnXtk6bLtDG7/AuaEKuTgLg9x9bmpIrvDN7ilZe9CC
         0gy/oaJy+2LIQ==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205101740.2820813-1-colin.i.king@gmail.com>
References: <20231205101740.2820813-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: cs4271: Fix spelling mistake "retrieveing"
 -> "retrieving"
Message-Id: <170179087386.845405.2039286765455444557.b4-ty@kernel.org>
Date:   Tue, 05 Dec 2023 15:41:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 10:17:40 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe error message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs4271: Fix spelling mistake "retrieveing" -> "retrieving"
      commit: 0be9595d8a1170474867b8ee2caf14394db45d8b

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

