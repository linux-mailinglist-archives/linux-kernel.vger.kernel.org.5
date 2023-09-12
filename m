Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625379D217
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjILN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjILN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:29:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FF10CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A3C433C7;
        Tue, 12 Sep 2023 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694525374;
        bh=joA/s9HxLmj5mbgpp98YzPF0gj00eYrxKM3dKzC3ask=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oUrvmRuT8jKFDpStsC7NUf8lcsy9C2W6q3iLrB6Dn1uQ/7aO1GlEEpc4NVpbYhgcN
         41wqTkTon3Hq493M2TAqMKkNTLDdM4CcfM5rB5zqj7Gib3J8hR8ehOjLz9PpMSmfup
         KcbZ0tAYLVkXQEX3ZzE9Ad7x92Xy7AmaYY6wfAiVW80O/m2AjHFzeC7jvQWC7HnYlL
         kv2dCCuWp+ypInegAPohdq4OxQvjrqz1HoMbkjFA4uAHOCefFe/nCR0KEJ8XfwVKjA
         AcKoiAoz+4RBefgaTxaLpFtv9iRmLnLpNGy369saYq6aIwEqG5Ccts9Ui0dvhRXYrr
         zgmjA0q2iVHJA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
References: <20230828172417.113631-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] Match dtat improvements for pv880x0 regulator
 driver
Message-Id: <169452537302.2406132.5562295237531472673.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 14:29:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 18:24:15 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for pv880x0
> regulator driver.
> 
> This patch is only compile tested.
> 
> v1->v2:
>  * Moved OF/ID tables close to the user
>  * Removed trailing comma in the terminator entry for OF/ID tables.
>  * Created patc#2 for dropping CONFIG_OF ifdeffery.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: pv880x0: Simplify probe()
      commit: 1b4daf643a3a21cff4bcad5b799960d5a0673d11
[2/2] regulator: pv880x0: Drop CONFIG_OF ifdeffery
      (no commit info)

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

