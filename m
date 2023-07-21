Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730CA75D0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGUR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGUR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C52691
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2820661D74
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FDD0C43395;
        Fri, 21 Jul 2023 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689960537;
        bh=tH9Vu6oDP9uli9pqzcgmOfkPTWvp/utvt/VaOAE7lFU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pkl84TfWd0Zm0t3YhHlbd63+HU8nT/nLKSsoW9XjobIvsRj09fHZ91Gh/2L2Yb0n3
         GhQcD4pn88jlO4S0dMP+6VvspLRB0VS7O8lB031xMnf0Q/lof1d4Y+29Xhz/0SfHYm
         f06t9axJOd0zwlq3wJSh1EWwYYcqW27ucki/sM5UWZa7h25y68m37S5LzpQ0br7sGy
         /77yiWjp8dRFjFqrwv5PLUIFs6IgD51Jn6hOGrZuBNq+2iBq54H8Ql4Ic80OeR0vZl
         vvJBH8/6ywhunYgR+ao+KuzUVQSFpz0Tjd4ysnRMeXVK+uUoIhQ6haUhYuVHQR9zUi
         GtqsgSMVF1cSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78868C595C2;
        Fri, 21 Jul 2023 17:28:57 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230721114423.GA12852@willie-the-truck>
References: <20230721114423.GA12852@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230721114423.GA12852@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: d4d5be94a87872421ea2569044092535aff0b886
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d192f5382581d972c4ae1b4d72e0b59b34cadeb9
Message-Id: <168996053748.13720.14127687111246912018.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 17:28:57 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 12:44:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d192f5382581d972c4ae1b4d72e0b59b34cadeb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
