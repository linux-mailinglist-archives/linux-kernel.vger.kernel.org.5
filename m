Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266487F8A39
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjKYLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:36:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926110E2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:37:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACBCC433C8;
        Sat, 25 Nov 2023 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700912224;
        bh=GwUm1z7JNGmx9AHHEHp+yhIxEyZUQY11WglFg95CV0A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W9CyEmT+nhx3j47D4G/aMS5ia8csPuTNw7uriGVZIc7jVTARW7T/r0/3s4NgVlg/k
         AqtD8DRgrIFAQQYmhj9V19qwLjEql8MmYEM040Sf0yQu8p3idp8aWPcXJDN9sWJbfp
         5uRfXeRoHP6rILn2XLGZLk+9A2F+1FV6yjReGcXuJJT4AqKA2KKaB4LtyVgcYyCo+/
         Qn2ZJ3Z/gdPEkwKRS/xjhrSAizw5q4NP6zUClWDt662LBHjjgRZRGHRH2Ja1Ddo/q9
         0N+CaHgKJnQ6y9reAiSj7dQ58eN2ffs0GtJNf4xqALCBTorTqD0fBrioSeA1KFH0nm
         ODxvbe09qYAqA==
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124095030.24539-1-mstrozek@opensource.cirrus.com>
References: <20231124095030.24539-1-mstrozek@opensource.cirrus.com>
Subject: Re: [RESEND] ASoC: cs43130: Allow configuration of bit clock and
 frame inversion
Message-Id: <170091222238.2632109.3145285136716343850.b4-ty@kernel.org>
Date:   Sat, 25 Nov 2023 11:37:02 +0000
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

On Fri, 24 Nov 2023 09:50:30 +0000, Maciej Strozek wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Allow configuration of bit clock and frame inversion
      commit: 52be2c4926831f7858c25701950afe9c1879f71f

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

