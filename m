Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5E7CCA00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJQRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJQRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:39:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B90690
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:39:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73614C433CB;
        Tue, 17 Oct 2023 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697564387;
        bh=0XW0onhMsdWHTogZuCFXILzxbu1EahYG2jAHnvIRFiI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rw6hcHRoSeoapz3OQTXjIuZxdryPugYP8E+cShs6K+4+QzVkPCmtPR6Fp+03Asz4P
         t17VNQMBGnZsEGuW9jn5sxL1OABwon+z58CxBVYLb8VsrZGgloXB4KNJveklGCYlfm
         DlzlasgrRO+leNYvBUaSZG++brezMhCaB1AZhmcQRZrNTP+e2mBqdFpaTIrkQTSHVl
         g2Ow7GKIW0Xs+6E9ZQOrWatwzNYA1OuX3IelnVGnrEa+jzrdo7Mif8rMybaDTvbMHw
         e/vAhlEB+ZSvTRhriVTelOw+a5jDZ4clQLTA1rtT5rkE0Or6CwdSg5QdDTh6A/If4e
         mFdmtBcFPwvXg==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231017071939.953343-1-Vijendar.Mukunda@amd.com>
References: <20231017071939.953343-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: enable wake capability for acp pci
 driver
Message-Id: <169756438519.1863854.149905912969891191.b4-ty@kernel.org>
Date:   Tue, 17 Oct 2023 18:39:45 +0100
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

On Tue, 17 Oct 2023 12:49:36 +0530, Vijendar Mukunda wrote:
> Enable wake capability for acp pci driver for Pink Sardine
> platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: enable wake capability for acp pci driver
      commit: 70227e1574e47a759422beec78675f1c19e56e25

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

