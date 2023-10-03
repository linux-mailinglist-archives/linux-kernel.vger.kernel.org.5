Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F907B6F45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjJCRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJCRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:08:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D219CC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:08:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05099C433C7;
        Tue,  3 Oct 2023 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352919;
        bh=kBYAiYxCZBMuNQp6t0UViUuBF5g4qPZxoWT5u3Qpvd8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Efqav5Nhw1v8H5daBY3EBv2WnSNt3YVcM0EK9r5hgI75lA+I9WakzLVSSG92btlMh
         GvsApHqbd+enECQNbzlBMy9gmL+HqTxGzByAVgVoGuH5Bso4ReRbNaIhx2mDorfAwD
         xq1xpu0EesldtYNUIifikkXN7maUJgw3OaW0z3QrEurxG2wJ4h/q0/lVIJbrcOwHL3
         SJSbFll5inBoxMxcn6C1Qf0HXrJved4adQcBPkIM9Szp4atpgoXDHxFkYE+UrFWshO
         quOjqLdYiExAW46OxLaIlPbEQmbiv87n/XSRLaIlnqYQmNXhYXNkvBQnV8vSmrPU4U
         YJWe/l7dk3LTA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20231003093418.21600-1-rf@opensource.cirrus.com>
References: <20231003093418.21600-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Remove unused hibernate wake constants
Message-Id: <169635291773.42044.3364380749891490318.b4-ty@kernel.org>
Date:   Tue, 03 Oct 2023 18:08:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 10:34:18 +0100, Richard Fitzgerald wrote:
> The two CS35L56_HIBERNATE_WAKE_* constants in cs35l56.h aren't used by
> any of the driver code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove unused hibernate wake constants
      commit: d4e1417bb9e675ea2e4d4a6f993e3a9ae8118ac8

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

