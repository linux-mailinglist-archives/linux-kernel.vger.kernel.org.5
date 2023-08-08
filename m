Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC98774371
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjHHSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjHHSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6D199E1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E57C62811
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A00D2C433C8;
        Tue,  8 Aug 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691514026;
        bh=77L5DB3TMRW5HAoPqhL/sGkYGdX75WqlU441uRSZyzQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pmjByl2iNZZkRuGdwnOfbFN/iE/b4tXqUpeV3l351vXMz3dv6kY1Qpljdijnvy1bA
         ECcJd/7T7QhQC9ZRcQgSC7O1jvXvy3JIZ5c4uXWzY61db4+K6bHz9UwIYeQfOZkjPs
         646sodeh2L5LJB/9CRMZtK6OvmnEBaNCMD48JKntwsqWZWb3wJ70qcziPKNEX6PrDX
         TzjsNPA2dDrBD+WJ7zqcsogjSHsj4Z1FLLHzYNLzk8mvXR9OmQRFUTgBgZSbIMtxEe
         Nrc3+ZVJgzzP0ki1wOrFK+FtdLcwYM+3RZTtIGp9aE/L5DePouHr9IurN+BEB+c2J4
         ncPTWDuDWJWhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E693C395C5;
        Tue,  8 Aug 2023 17:00:26 +0000 (UTC)
Subject: Re: [Cluster-devel] [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230808125315.1727575-1-agruenba@redhat.com>
References: <20230808125315.1727575-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: "\[Cluster devel\]" <cluster-devel.redhat.com>
X-PR-Tracked-Message-Id: <20230808125315.1727575-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-fixes
X-PR-Tracked-Commit-Id: 0be8432166a61abc537e1247e530f4b85970b56b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02aee814d37c563e24b73bcd0f9cb608fbd403d4
Message-Id: <169151402657.3633.463157749123463374.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Aug 2023 17:00:26 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  8 Aug 2023 14:53:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02aee814d37c563e24b73bcd0f9cb608fbd403d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
