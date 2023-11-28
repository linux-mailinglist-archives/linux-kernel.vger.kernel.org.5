Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8C7FC241
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjK1RrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjK1RrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:47:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8BB4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:47:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD56C433C7;
        Tue, 28 Nov 2023 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701193645;
        bh=bDt071erLT9bqXvQLkQlZpysK3yPXDzuHNctSH1FSC0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G7WcGKCKn7yGsoXwbOAM+pHeOWQGJz1QNXf4MfqqVelYmMe7g6mdsCOOeEsA1f78s
         GrxZCmEWaDv9spKonBmSYfjeA9Sgp+JRNJTdYWCo1I9XV5u0Dn6VNya2Zp3JklTSFt
         QqMSU5ZYFq/a6imm45go70KU1yHGUYLPli8KeBYj0A1ym0rxjVo/9a28QZfjVl0yzw
         INuibXZkhlYCOh2PTkULMW3Waogyt2JusnwCarikSDaO87nmjEs074DiItvsSOoQel
         LzVP/U4EnZ3ESYGjB2hCHqUh9XmDwsbyyzn1+PMxIVcGODm22LiYy2WCUZ62IvbuOU
         gZSpQmK/UHTbA==
From:   Mark Brown <broonie@kernel.org>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <871qcbszh0.fsf@5harts.com>
References: <875y1nt1bx.fsf@5harts.com> <871qcbszh0.fsf@5harts.com>
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-Id: <170119364376.61148.2092062519841116796.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 17:47:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 20:36:00 +0000, Malcolm Hart wrote:
> This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
> to enable microphone array on ASUS Vivobook GO 15.
> I have this laptop and can confirm that the patch succeeds in enabling the
> microphone array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: amd: yc: Fix non-functional mic on ASUS E1504FA
      commit: 03910b4da940871f7cb8ed84837bd4b5ff9366bc

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

