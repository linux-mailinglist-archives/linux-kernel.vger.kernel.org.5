Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97C76F31C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjHCS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjHCS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DEF2D5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B37361E74
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45719C433C8;
        Thu,  3 Aug 2023 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691089141;
        bh=2v7C+V58OJPtZFXbcYDdpVPIVwHrJZxcwt59CZpHWt8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NnZbZDRTpSnOx124IZgTaYJLCy0Oo87aQf7FDETSbVo4hjP3uF7Oi6XDlVuZI6heo
         VY7xzTOtBmcJHAe0sWoBc+PF6fwM4JL7PveQBhcpJZ/+PwaKaZi7uYthLHitZV9njd
         fuGK6GvLJiMWoW1JNHt7qNEdybo/nYuXCHbIjJgTj9AnSNz6ylhTZ2i/ZuHX2K237s
         xATRVdOQ7knCQ5DepFwuDwnKk2OEZ48cloqRm6eX+77iAFCHx2VSw5iBkpIaSqkwUT
         c8rK3J3JenSp6GX1FR31cl0Ig/0HRwQ+avSe8MadCWq3vy+xTxWhIMIechdOt6CDaL
         Nrjs8KOnQWGDA==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230803162312.117771-1-ckeepax@opensource.cirrus.com>
References: <20230803162312.117771-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-acpi: Add missing kernel doc
Message-Id: <169108914000.123358.13591899425970131423.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 19:59:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 17:23:12 +0100, Charles Keepax wrote:
> The UID field in snd_soc_acpi_link_adr is not documented, add kernel doc
> for it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-acpi: Add missing kernel doc
      commit: 9f0d4d47c7915ce21bde4a4974a7a6307e244a6d

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

