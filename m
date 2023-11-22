Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398F7F4187
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjKVJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:25:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A399D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:25:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E5C433C8;
        Wed, 22 Nov 2023 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700645109;
        bh=BEMLKuoWZV+6S1km1/qTddZM9UR4ULUGcsQA6SVus44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q8Cw3r7eA34IHJpwsZqG4hWY+IdkvF0IW6UaRzG2aOIBJtKQgOd0Fz0R/RN8OunoP
         3qZAW/lVnvLig36NXa2WN5Klx0ZN4oJ+rqNmRrdCOV2ijgzK7odBf4neJXVbGQX/1v
         ZK4xXMFarMx3elX5SmhS8k7SvSpY07zW+zGH8MqMKBbw5l3BbJaftEIZLghgn1/xKe
         p6o+FrwdQ8qis8hBpFEhwP5GKx3B6ooNVLbHvePEdwC+sYJgyJ0/NLnhZ8/9NIz0o1
         rWWfYniq88AVE4O/ZDky0zV09C65rCkmTvXHaDyjIFxNVPwUU3M5YnhCOsApzFnny/
         NxujBrKVdTDHA==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231121230900.3754785-1-hugo@hugovil.com>
References: <20231121230900.3754785-1-hugo@hugovil.com>
Subject: Re: [PATCH] regmap: fix regmap_noinc_write() description
Message-Id: <170064510867.2074624.10676780350384273282.b4-ty@kernel.org>
Date:   Wed, 22 Nov 2023 09:25:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 18:09:00 -0500, Hugo Villeneuve wrote:
> Change "Write data from" -> "Write data to".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix regmap_noinc_write() description
      commit: 1957b92aaff0fa71621e61bbd0257b9c3bb9baf2

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

