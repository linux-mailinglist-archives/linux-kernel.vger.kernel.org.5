Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FC79C25C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjILCI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjILCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BE1A39AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BF7C32785;
        Mon, 11 Sep 2023 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476692;
        bh=DdAhnSb6eTmencHdJoDAsclZ/Z+n4EKofEUHJ1xa2M4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qLqrB0uBoi0Ffm1e1V6TFNOR9dw6t0bSYLz+ObiZQdgjmbSgzqHfQPKdbwyB6E3gD
         +aazMZ3vphnpMWqEPLqGrm4Bb781m13fkb+6NjBLthSm81c4qT2PpdD5ahvdgsjWVw
         oi/9asiPxF7X2nEDmZpPJKiWLENoqg0vyoMdABoK+N7px2zdA9Mue0L+PwPxmkCeQV
         DgcKLQdk34MLuR632R8U74ggVzsGHp1US2Pm12vedg7WmtQBG4lrMQ7CSXvxW/egrB
         m9t33YzCwURpUQku2agLwWT93PPohggd/P8XbrL8rhDDwjMt4NBQBOgDx5tj+dQjsC
         7IOBL04k2DB5w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828165447.106058-1-biju.das.jz@bp.renesas.com>
References: <20230828165447.106058-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: sy8824x: Make similar OF and ID table
Message-Id: <169447669157.2387765.5800520554508303390.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:54:47 +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.
> 
> While at it, drop trailing comma in the terminator entry from ID
> table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sy8824x: Make similar OF and ID table
      commit: 24d95bb0460aeccfa008faf12721474336d4e0c3

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

