Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A257CF723
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJSLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjJSLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:39:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A79131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:39:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1174C433C9;
        Thu, 19 Oct 2023 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697715561;
        bh=676Rjq+LE+0fgew437xG06OYxKy/BUx3vyMw4uKlDRY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nxuvfXr0NdkqgNKDibvY5zZVlOquM0vrsHJ6aWJa8REP1fYrVCrJY7tEm5597yMn6
         AjB+GUHDS0cVa7DJkgTkLQculCExmRAxd/vb5CpFSCfHPJPJ3R/hWgXMPFehieFweP
         3+cjJ8TtNGSpXeUysAOTJw8H+MJ6Ejd/iMXJ+AL43Im9+pPAZw7A4G16NpkQBTLZjF
         NtKjRt4Iy9iAvKsULXe8sjSD9J8XBaq8224kdOHDuwCbugvwT31+bNgarWkV0EPQ52
         ejXLmm7nNFx1EbleUkBO+uSVaJQt6NjFgZVlzIhIeWNSixEoP79NcVrxqBwZnyLhV2
         QAJ9q4wZ0WFAg==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018064444.23186-1-David.Rau.opensource@dm.renesas.com>
References: <20231018064444.23186-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7213: Add new kcontrol for tonegen
Message-Id: <169771555936.23143.9693813241096265778.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 12:39:19 +0100
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

On Wed, 18 Oct 2023 14:44:44 +0800, David Rau wrote:
> Add new kcontrol for tone generator
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7213: Add new kcontrol for tonegen
      commit: 64c3259b5f86963c5214e63cfadedaa2278ba0ed

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

