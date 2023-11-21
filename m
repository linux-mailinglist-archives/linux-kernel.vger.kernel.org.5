Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0977F366B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjKUSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjKUSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:46:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45711D40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:45:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E70BC433D9;
        Tue, 21 Nov 2023 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700592356;
        bh=9WC8aqJ6oZ32SlXJ7faib65Qf55EOmQoT+BGw8wVCVY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kCGGh0aDTr4yCXL3F6PhpNEEg8N3gvA9MiPxP+X+ZS97UEM3YOKUZIiIdbWr/kMKC
         pBjJcTPjI3C+mWnPCTvko9Sc525p1YixKgGHn6wqqkCJ6fH6SmVhfWRqmrBLV459Pr
         7cqiZXGEbwZXD9Vw1Uzusklfdq261Nhhd7LxYwW3Lr4eWgmhYWO9zXPjGIHR/awWMf
         ZDumBxi+JUHERekmp4R+etCrSCoBxiIGDidHCjI2smA9UueC70vq+ZJobMWcOaG6vL
         4aoYv5i2RVccARukINsuNDhig3mu1CygEovgHNcBnjGxicaP3BO6ViFCWRA0nUcKZV
         E3RHJxW9Tku3w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231121120751.77355-1-cristian.ciocaltea@collabora.com>
References: <20231121120751.77355-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Message-Id: <170059235481.1901021.9703531954255937779.b4-ty@kernel.org>
Date:   Tue, 21 Nov 2023 18:45:54 +0000
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

On Tue, 21 Nov 2023 14:07:51 +0200, Cristian Ciocaltea wrote:
> The virtual widget example makes use of an undefined SND_SOC_DAPM_NOPM
> argument passed to SND_SOC_DAPM_MIXER().  Replace with the correct
> SND_SOC_NOPM definition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
      commit: 67c7666fe808c3a7af3cc6f9d0a3dd3acfd26115

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

