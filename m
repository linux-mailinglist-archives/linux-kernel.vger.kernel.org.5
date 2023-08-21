Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB5782B90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjHUOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjHUOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B2188
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2756C62B57
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9613C433C7;
        Mon, 21 Aug 2023 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692627633;
        bh=6halJ5bWFOpfD5Uzu3pfLpn+c1jV5oOJUbrgcWavBcs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uCoeGLLxQn9emuNcm/5A82e6wBDD0yoo89Vo5gAmGtWwbKYd1lWmDQ4KE2hg3HDbj
         atA+NAxsL/F8ks3Hyr9djfacu5rg/q1TpNzk145FHABD1cL/AimpgDHFU9jJKqtqyO
         OuiX9cy4pMP70TkANmDdQNcRxIA6rGrtxZ8NRl5ojiMHH5rdJDCA04oNkxdSQkvBTX
         8KbT4P+/0uNqVKR5GYIHGo0/icoOlB8jtHYxA0mSsJpR4qsRCPUI5AgtiBOJ2jnsw+
         Azzw1PSh0x1ZIAiZ40eTRMOtL9zdEzhPebwj94+u9udYsJNwomZVDo6URgSGcJst/L
         mK51KdtUUSZwQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230818124227.15084-1-yuehaibing@huawei.com>
References: <20230818124227.15084-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] regulator: db8500-prcmu: Remove unused
 declaration power_state_active_is_enabled()
Message-Id: <169262763261.266290.9042568039745231877.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 15:20:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 20:42:27 +0800, Yue Haibing wrote:
> Commit 38e968380b27 ("regulators/db8500: split off shared dbx500 code")
> removed this but not its declaration.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: db8500-prcmu: Remove unused declaration power_state_active_is_enabled()
      commit: 35acbdfaf17c94d64ee336282f21b2981676748a

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

