Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D079C262
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjILCJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbjILCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577441A39B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7389FC3278A;
        Mon, 11 Sep 2023 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476696;
        bh=IyjEmLzop4/m+8p26FcLuLRskAfQqTBZcsFDORGVBxs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uCgKKWScfwp34L4pM0priT6Kyg5bpGXIJgBKhIlITLenjJ+o/heoucghTePZ6oCik
         FO0Dq7X35BgCTW4CmVmdVAarO1WtQocWDEh9INCs4X/0BcTVyiAJajIMxQhEojgKyE
         cHjiQQZfefXsP+lk++CYl8c/mJYWY03oGVyP4p0hsGWsrcoXtu/IQ95C5Mp9ugxBKj
         zFG6oMOqKjjSCNGtql55xZr+s2FyqhVsyPEcTmlYGpcqVwGFPeVxQpHnbpFe1qbtjz
         RxQU4NAOmYYl6gB0Bo0Tj4n7fwG6jj4eg0r2O3+Z6WUgfvB67nlB8unz04KSuayDeu
         NPqL24iMz0BlQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230903155125.73638-1-biju.das.jz@bp.renesas.com>
References: <20230903155125.73638-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: mp886x: Make similar OF and ID table
Message-Id: <169447669509.2387765.5847466162965415646.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023 16:51:25 +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.
> 
> While at it, remove trailing comma in the terminator entry for ID
> table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp886x: Make similar OF and ID table
      commit: 9e38482cb562f03fe8d521a001d44eba176a9201

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

