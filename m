Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A847A0268
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjINLUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjINLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0651FCA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7ADC433C7;
        Thu, 14 Sep 2023 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694690385;
        bh=g5Y+W+fEfFjASOlsvhwzFczRz/xSyswp99GTZRJ8t5o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B+PkzGir/DRNMzN3QXhNTw8h3I+MqNEMR5BXHWXO0+5yDOVBmGJmv1qqDKGaZDgtx
         f2iYaxPqZ6RFRs6TJw/7MlNLR2etIBUPka7uXh+2j86vfmyF6ItkCLl9g2AltCKs46
         rYdLEkyC7VoqY4diY6PgF8JvYeglFHWSPdLSy8GUwhcW3qEl1ddBcitBouE8/XMFUd
         sWIf586Fuknkf1RKi9B3ebZfV5v9VW/EztQJgV6i1PCUxhY3p0ePDxdNGWkGWxRAPp
         dDEQNcg1CKIEIqVGj3cyBM7zbTaycQZv4fxdf5o5y3my1qh6Fp1JZT6P20nbH/GfZY
         zja5yuER5gB5g==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230913210916.2523-1-posteuca@mutex.one>
References: <20230913210916.2523-1-posteuca@mutex.one>
Subject: Re: [PATCH] ASoC: amd: acp: Fix -Wmissing-prototypes warning
Message-Id: <169469038415.23670.15827539133366262566.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 12:19:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 00:09:16 +0300, Marian Postevca wrote:
> Fix prototype missing warning for acp3x_es83xx_init_ops() by
> including the header acp3x-es83xx.h
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix -Wmissing-prototypes warning
      commit: cfaa4c32ccd3a4cb1140416a9ab51904e938d767

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

