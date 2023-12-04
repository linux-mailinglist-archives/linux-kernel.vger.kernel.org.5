Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA301803A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjLDQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344779AbjLDQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:29:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CDC99
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:29:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E64C433C8;
        Mon,  4 Dec 2023 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707361;
        bh=l03PGOdUpXAjQJxyhn2jCXzYkIewX87iY4tJWHWgmbs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ElLbXAldfKAr1QHhgOyNO7vKUquxj2w/umm0r0AAKpwnRsqbsPw3RgXUFi5Y+zc8h
         suMe0+B2kAiUofDF32HCEPrZVMHLL67XdH5C3WhzY3MR9QB0FscTWyFZu/O58NYyOz
         K0CzmmBM/H3xwmDjtwf5QHCgKQRlq2VBnHzWj0owcVTfsvyRTgzaYuQLJ9TVh5IjGe
         grY5mJV1AEsxE/UiL7LqDyab/5hOQjB0gDlU3OYC+br+d2wxq0TaYbw8bhNeaKm4tl
         ImwdOL5kDQpQZ3ZYVk21NQsr3g6PoyuXtbydLGAdV9huQ9U3nP+4KJ9t/aslw9c3ya
         UO8APZnBELu0A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231202223001.8025-1-posteuca@mutex.one>
References: <20231202223001.8025-1-posteuca@mutex.one>
Subject: Re: [PATCH] ASoC: amd: acp: Add support for a new Huawei Matebook
 laptop
Message-Id: <170170735951.96782.6842317047782976918.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 16:29:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2023 00:29:51 +0200, Marian Postevca wrote:
> This commit adds support for Huawei MateBook D16 2021
> with Ryzen 4600H in driver acp3x-es83xx.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add support for a new Huawei Matebook laptop
      commit: b5338b1b901e41bd7cead66a0b3a796e9fa95684

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

