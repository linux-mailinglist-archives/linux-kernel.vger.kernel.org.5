Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7379C242
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjILCIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjILCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3F1A8284
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B6C3277B;
        Mon, 11 Sep 2023 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476668;
        bh=UTHfskCPxfT0CkxuCk8AMyzTpjekFNSPymhm+op3rqA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OuNP3e2Ngm0xtfKhjqUdTqC1Keeq29pezrRMz7trEeHEZPExjHJC6VNRu3Ir15niD
         TfFgKaSywSBUbRJ4x9BhkiPiG6ciFIl2Q4mWfWsvQXcZXVN2bc42cx1q1VWtppcJ8+
         e7gEPBKCAqFs4EFly89/+FCC5NARjjNFl69T8ogBNlhhwQFO2wPtBUubnMR6whMkfb
         opi6GgkzHDDtA8vRYhL2lALutTBJuQE69b7c9/dW3rmFFq2A/odFhgBOpWRZxHlbkh
         UKAezSTZDd1a+fGyfuQJLyEy6b7q3zA3OkhI+GiDDU850y9AdBPxywaDYbuzDlrhgp
         7U91uODV8sanQ==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230904111524.1740930-1-andriy.shevchenko@linux.intel.com>
References: <20230904111524.1740930-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc.h: replace custom COUNT_ARGS() &
 CONCATENATE() implementations
Message-Id: <169447666642.2387538.16208384121056477598.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 14:15:24 +0300, Andy Shevchenko wrote:
> Replace custom implementation of the macros from args.h.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc.h: replace custom COUNT_ARGS() & CONCATENATE() implementations
      commit: 428cc4106a430781020eedc68e8d0511380eb0ef

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

