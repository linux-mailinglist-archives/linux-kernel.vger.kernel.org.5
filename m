Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225E37DC69A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjJaGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjJaGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:31:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39128C0;
        Mon, 30 Oct 2023 23:31:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA4B5C433CB;
        Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698733882;
        bh=zcVraLAJJOWSQH0Yfzw+xpDWVjcaiSIuyzoUZeAQhYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uXxhaJXS0901z59SGEYXRFhBWDbhaoIbvlK0nethmhH8QLKbTSUIJGxekCBqwd8NZ
         A1RqxUn2c4gO4HnL1MX22y0j/4/Jcf/2I4YCSfvZzKNvU2oipuR9i7bXTb2JSokAMT
         QzO3/fy+wtaUEnu46fOgWqiUd0FMYTIWKDTaxrcmez2TrqO1IIY3iHr5llXBWsu506
         wNFknn2fEeNlV6pLWS1i+JKZ6tPwOnFANkKaNQq4hr6+b0YflsjgWw80Rez+H+VZBE
         4gKW31lwmku7ZEQ4gEvlST4wz20NseCSqorlmUDbh3iuUJs2fNb8PDhzmf52dgnZnS
         GcigWK5e61FtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6496C4316B;
        Tue, 31 Oct 2023 06:31:22 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20231030
From:   pr-tracker-bot@kernel.org
In-Reply-To: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
References: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20231030
X-PR-Tracked-Commit-Id: 19c1c9916dbf9b05157a0c4970f61f952c0cb86a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5fc9e4a117d4c118c95abb37e9d34d52b748c99
Message-Id: <169873388280.12768.6660207845149952813.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 06:31:22 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 22:16:31 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20231030

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5fc9e4a117d4c118c95abb37e9d34d52b748c99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
