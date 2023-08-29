Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9D78CBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjH2SIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjH2SIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BD19F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A4D637D9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8052C433C7;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332485;
        bh=jAk0KtDvCY4LfuOE68a14S3kNONHyf+EchaeOufePPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J/dPpZN2H/gYpcO0AEhyR2yQ99tFDsR7s1g4u9/4XYwdZumjFuilnDWRXXRxOPFGX
         c+1ZmEmkxyW/yN1c4acBmOX5tlWjIf485c7rdSAxaI0v5kjYXEg31X4fZ5YOOR7jP+
         fqG9Tv8lCq1saZ/i79Xu8wya4OQ7CtDGgEJRW8mCU7KMobxm81staSC8erEdD8bVDY
         7Uuy3OPb2uMVuHz0fe72CpfX1V9KCXG+rD/9IF7p0mvTf2FoXywMKhbQYL8NhutqWx
         g+i2uwRRPo318l7DtCad2PaQXMJoeTo1TpnA9tftgOmA10lcqignwWIDclcsMv35Xc
         SDbGIXEsFtitg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B37B1C595D2;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32ff61b399fada600de5cb9ce363fa9d.broonie@kernel.org>
References: <32ff61b399fada600de5cb9ce363fa9d.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <32ff61b399fada600de5cb9ce363fa9d.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.6
X-PR-Tracked-Commit-Id: 5d481ddb6a731281238b6a064c719a91f0234b0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fc81f376468ce67d70ecd1016dfe901a51a39f5
Message-Id: <169333248573.16601.13872256883039235875.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:17:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fc81f376468ce67d70ecd1016dfe901a51a39f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
