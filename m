Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFE7B5A88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbjJBSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjJBSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF659B;
        Mon,  2 Oct 2023 11:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF30C433C9;
        Mon,  2 Oct 2023 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696272668;
        bh=5CTwTLBEvduUICvuu4skaNUm4ejcj7Qi7S/UNZzRJiE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S8AF7ciAoQ2kkg5GltwcBo7ww4CDBBhPHcFnC3/w/u/OM2IdygZ8Nl11+7XXddPCm
         A4MP+YkhXNhN515RN+L7svKr7FzXiq5K+G1zWkgOV7wkP9dTBAn0sCHNtTRUY/4bgm
         L0z8iUucUsRpPB6zZCW93SpmPCBSbyeQQxtbzJf+BtTBJQ0cia/HAL2FtzV/Jv632g
         6O5GdBPF8D606o/VXHA0vm1zAuj4PXkPTq2b+l1+UrBsb8Q0IRIGSVoi2OJKfvpBYI
         wDsZQekeqMPdBVCsOJ7a5h5Em9RLPQwdSLGSbpSMUdoxgQ7S9Rm+l4okPEf4QtUjPk
         8wDzs1JM2oQpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sven Frotscher <sven.frotscher@gmail.com>
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev,
        stable@vger.kernel.org
In-Reply-To: <20230927223758.18870-1-sven.frotscher@gmail.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo
 82YM
Message-Id: <169627266558.110968.10545623851131128761.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 19:51:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 00:36:07 +0200, Sven Frotscher wrote:
> Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
> requires an entry in the quirk list to enable the internal microphone.
> The latter two received similar fixes in commit 1263cc0f414d
> ("ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG").
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
      commit: 1948fa64727685ac3f6584755212e2e738b6b051

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

