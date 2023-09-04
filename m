Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB8791A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353169AbjIDOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjIDOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:55:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA498AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92DC7B80E6B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDBC433C9;
        Mon,  4 Sep 2023 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693839320;
        bh=1Xht2Mwat7NsM0EmnlY4HnsXVjVOfaiXTqnZtnMB7bw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ofhe2dY3QayHTJLNoFXW1G4KfTlZyMHWrOSbvV8pDOB1F3RUKZDBwLL3kmcO70ocE
         20/tNNMiqT7n0EcT1LMvaWFkcpWdk6NhnEyvfeSXNuMzaDrvUn38+RRWSt2j8wlTpI
         ZB3eFPDAxiROCElPqIa/RDbwOTlTeKjkmvAcvfUxDqCd1n//4+tc4weYHHrpKfHgtm
         4XMP/JAE2EelyUE2gZ+IK6I1NoNWriRBc5yomzpRjr+dVeQi02/0B60ALDnbVB2asZ
         DTYcjufe7nhwjoMT1a8ZJLfD9O7eAt1u42RBTl8McEUvbwi4bU7c1QcwPhZ/KUX+bq
         aYB6u7IPQ1QFw==
From:   Mark Brown <broonie@kernel.org>
To:     peeyush@ti.com, navada@ti.com, baojun.xu@ti.com,
        Kevin-Lu <kevin-lu@ti.com>
Cc:     shenghao-ding@ti.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20230903161439.85-1-kevin-lu@ti.com>
References: <20230903161439.85-1-kevin-lu@ti.com>
Subject: Re: [PATCH v1] MAINTAINERS: Update the MAINTAINERS enties for
 TEXAS INSTRUMENTS ASoC DRIVERS
Message-Id: <169383931861.34217.696447356576991523.b4-ty@kernel.org>
Date:   Mon, 04 Sep 2023 15:55:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 00:14:37 +0800, Kevin-Lu wrote:
> Update the MAINTAINERS email for TEXAS INSTRUMENTS ASoC DRIVERS.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Update the MAINTAINERS enties for TEXAS INSTRUMENTS ASoC DRIVERS
      commit: c87906a7d56e1f26320a6c8f6d8306656e78b353

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

