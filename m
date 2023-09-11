Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFE79B2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbjIKVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbjIKPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:09:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEEACCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:09:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9CAC433D9;
        Mon, 11 Sep 2023 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444940;
        bh=FNwiZky5nIsUMiFSy7nXej3Zdr1lH6C0uhWn5tULBJA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=W4KK5zpd/ADT2bDqknyYoxvk/UBZSsuvECcJt9r+G8PTNpzvtizrE3/EuY+83Fytw
         Isa3oplxk0C/4PsNgkB9y8rWVuWbRVIp5YxgXjm6zdBZIFWH+1uAZd4oTCdkUPJ7Hm
         ytWCdH8Uykj/H112g0kz8j4rJLKoY8HTikh355h/FLn7gJnYK0HddVzc3O473qwGTl
         O29LhtzmzfhCcgka18u7i/hhAT4k4IZoO0bql7qtJ2mzQT9f6woVyyMNQsRs6PThF4
         5W0v/uqrGSzdlWLpzCz7oTPRzx+Ex2xnnRYngfn7eTcz5DkohhK7Ov4ueSWe9sfQuu
         0jl1qhHbYxMcg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, Walt Holman <waltholman09@gmail.com>
In-Reply-To: <20230910185433.13677-1-waltholman09@gmail.com>
References: <20230910185433.13677-1-waltholman09@gmail.com>
Subject: Re: [PATCH] Add DMI ID for MSI Bravo 15 B7ED
Message-Id: <169444490120.1851820.5934729126873072182.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 16:08:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2023 13:54:34 -0500, Walt Holman wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Add DMI ID for MSI Bravo 15 B7ED
      commit: e616a916fe8431ebd5eb3cf4ac224d143c57083c

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

