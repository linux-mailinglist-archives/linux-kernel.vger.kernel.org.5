Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C171E788D73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbjHYQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344123AbjHYQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1CC2133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2B56643C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73DFCC433CA;
        Fri, 25 Aug 2023 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692982283;
        bh=rrtrv6505D6+mKfj6d9ZGrF3wcp4skTS9g1LgMRmgUk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JtHfl7b2USxlC3GVa9bu0+Zhy3E7ufYWuE6oWoD7doA//oWvjHc7B3nak7yDZzGXH
         bUqSEG5pFE1FF/TUMDdCru4yzTE58fOiaTQLvSRa3GLtVKqTgFk+XxaGlbHvjjKTo7
         PR5O+LCbatS0m2mBvuJwWl3CDlmP5EyjCEJCynsI9QTyVR8NBFujCfuqaaU0ji3Fhp
         vXeiyju6Q1K/aAjCtdUxJSdzJ00b0G+AYVQFxPv2sqa7ULrvlBUMeG8FsSDm9BXTaM
         n1T+jSpFT4WSASKArHNHKZosd/EumioPlZNJuRimDQzkmoHsPkugJaEK9yUqmxy/WB
         SOjUxX+bw/MKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C02DC595C5;
        Fri, 25 Aug 2023 16:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.5-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f80b6a8e-79e3-486b-95e4-18c04a1be0dd@palmer-ri-x1c9>
References: <mhng-f80b6a8e-79e3-486b-95e4-18c04a1be0dd@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f80b6a8e-79e3-486b-95e4-18c04a1be0dd@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc8
X-PR-Tracked-Commit-Id: ef21fa7c198e04f3d3053b1c5b5f2b4b225c3350
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4942fed84b98cfb71d3cdff1a3df0072a57bbdfa
Message-Id: <169298228337.13860.8193502050877507785.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 16:51:23 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Aug 2023 06:16:41 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4942fed84b98cfb71d3cdff1a3df0072a57bbdfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
