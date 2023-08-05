Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8F771210
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHEUTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjHEUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9C1BCA;
        Sat,  5 Aug 2023 13:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CDB860EF0;
        Sat,  5 Aug 2023 20:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE9D1C433C9;
        Sat,  5 Aug 2023 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691266742;
        bh=gbAV6KRqhKF7MZ+ptikkA5jMdlmvI/esHYBsCeVYsHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fEtU1gq9tepSFLgqK8XrqUJ0X2fOlGJhyXzJHr2bb55nhAwd+N84s/ffR5PZuPlxX
         hhTgUe2AYc9r5EBCSlT0emmMODVaDG3Zsbwa0j4NZN0bawTOjlubVX0rWq/3uZRGbU
         5kFvKmf424l91heEZ8QGVch7Lr2xgW7RSQA9P5fSg0Ewq0kOpl09QmrK5KnfiqaKiA
         6vvgcfulFr3fEsad2ftocE4mgYG62vi8mK+JKXFbJPVjPMbgXDVKW1TaC7AcEn+19f
         PPRLQP6BPSH/QCrLc4PDDa+9NHo/kbwAOW2ciKrgVOcEAOw3j8rLqBfGFolhMsArZL
         uwJ2LQAqZ728g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D82F1C64458;
        Sat,  5 Aug 2023 20:19:01 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZM3l7IiQKzkkN29S@p100>
References: <ZM3l7IiQKzkkN29S@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZM3l7IiQKzkkN29S@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc5
X-PR-Tracked-Commit-Id: 99b2f159b6e76b84357eae6dc2a206871aa630d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 947c2a83584d3093efea1edf52430db47f11080f
Message-Id: <169126674187.17470.14029658406473487025.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 20:19:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Aug 2023 08:02:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/947c2a83584d3093efea1edf52430db47f11080f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
