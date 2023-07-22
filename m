Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2675DDF0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGVRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DC2680;
        Sat, 22 Jul 2023 10:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719BE60BA1;
        Sat, 22 Jul 2023 17:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDBD3C433C7;
        Sat, 22 Jul 2023 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690047392;
        bh=4veDvID5ILUnccAnYdZvyEgmdNW42cXu/waVUUKvCXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C8JtNrxpYOnJZLhBdOfWGTDH6BL70RpqvgK3O5f/J1hxSxg1JUUiXcdYOYm/5oLSe
         v/HsMaNPMvOX0bMuvoj4nEfDyUsLKkz131Ao1dylM57rlluVV0YCBh9M7GAdFKeri2
         mm3uiXyS66WtSsBG2TO1gksIeiyH1b4H6w6ISwuWMSrBkl+PymaXmLmUEYZrnypY6P
         cFE96ZbVvVvKXMais6Ny/TFwkEmRbNuMFy/W1xQHvhrINDyRiLiazsJ5iYV4OWPrjg
         3Ehpaps+EOqiQ6Ip/iv5pGMvLgfdv0lwKoriGyCs/D4a1tBqFw2IlAKeMgpn42bQiN
         L4rX9GS672IpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2284C595C0;
        Sat, 22 Jul 2023 17:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.5, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230721195151.GA1691988-robh@kernel.org>
References: <20230721195151.GA1691988-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230721195151.GA1691988-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-1
X-PR-Tracked-Commit-Id: ffc59c6414f9ffd52591786efe3e62e145563deb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 725d444db6b0a8ed98461583ed1e6f12b8a7f0e9
Message-Id: <169004739272.21373.9936211957901999724.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jul 2023 17:36:32 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 13:51:51 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/725d444db6b0a8ed98461583ed1e6f12b8a7f0e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
