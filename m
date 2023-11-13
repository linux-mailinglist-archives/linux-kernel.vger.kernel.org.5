Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014747EA3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjKMTkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2B6D46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF93C433C8;
        Mon, 13 Nov 2023 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904417;
        bh=8tmAr4oKfMzIrHzzCsXIaxkR7VWUld3c2NExSZ1Z27I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xaz9H9PBMCpkn9qKZf/A0OdhWKIHJ388XEAuenzBTskRpdGn5FMmIal28QHYHaE2Y
         vk2XWuOex/eFC+BLD/u4mi+Dy0+kcJtIsiwvPTn5+rLiMn9dtsrdipD16wYtGInY28
         g7lRtDLgkuMChoiRTPcowwLiUZZnoIfVfxMR1JBjxUAwxrdVjNbceHJHE4lxyBMmo3
         JhZH9HROxwYNStVjqMozeI+sYCgGs+2PHnLASjNTLnKXxF3N7LlnCVrG9VckNZxmsS
         WxNIV0KA3QQes2W3cn9kB43oTVVbk9/MozBQrGjDlhhZfBBb2nSFAJg9tMOyQiq8uB
         0eJA6PiGjwu6g==
From:   Mark Brown <broonie@kernel.org>
To:     Matus Malych <matus@malych.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231112165403.3221-1-matus@malych.org>
References: <20231112165403.3221-1-matus@malych.org>
Subject: Re: [PATCH] ASoC: amd: yc: Add HP 255 G10 into quirk table
Message-Id: <169990441610.3293939.3564976068845326925.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:16 +0000
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

On Sun, 12 Nov 2023 17:54:04 +0100, Matus Malych wrote:
> HP 255 G10's internal microphone array can be made
> to work by adding it to the quirk table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add HP 255 G10 into quirk table
      commit: 0c6498a59fbbcbf3d0a58c282dd6f0bca0eed92a

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

