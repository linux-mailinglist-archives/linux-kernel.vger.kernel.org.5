Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4699D77D183
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbjHOSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjHOSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BC106
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62254650FA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAC1C433C8;
        Tue, 15 Aug 2023 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122956;
        bh=a+wcj4c9yPbq+exLW1xgnnjZ0kZlneV43gMUPE8MB/k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NruupVuQxDgPJrpV1JKedJOf+r5jVgBI3x9d0cOdoYPTxiBUXXUzmAacVwpG39A6b
         JkgLW7pTC8f0qD/vcYBNN6nHx41fALVu/W7nTeYzfmqmaes/9hJzRsDyMyV6aLy3u0
         wEMR31e+vH/lAbRR8jFqT7J3qyL3b42LOuyfxuYI117U6KwKhE/s321aFyrf/iffXd
         SE+6CJ6wP5iJtab1Eu8KtBASw0yXurDjVTFZV9e52jwkXlXJGTQqZswiaOBTVdEY9e
         vx9BZV7Pau9U5vGRZEhe8Zdll8GhvfhN2bKLKaySbGk1xY2bohlx4mCt5iv8WLmTBL
         JIiMqaUwUr91w==
From:   Mark Brown <broonie@kernel.org>
To:     peeyush@ti.com, navada@ti.com, baojun.xu@ti.com,
        shenghao-ding@ti.com, Kevin-Lu <kevin-lu@ti.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230815095631.1655-1-kevin-lu@ti.com>
References: <20230815095631.1655-1-kevin-lu@ti.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add entries for TEXAS INSTRUMENTS ASoC
 DRIVERS
Message-Id: <169212295513.59295.16699540147376828272.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 19:09:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 17:56:31 +0800, Kevin-Lu wrote:
> Add the MAINTAINERS entries for TEXAS INSTRUMENTS ASoC DRIVERS.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add entries for TEXAS INSTRUMENTS ASoC DRIVERS
      commit: 0fc7769e54e747c8fd1b4899af2ac43cb68daa1c

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

