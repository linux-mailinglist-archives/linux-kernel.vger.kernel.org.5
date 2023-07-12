Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52475146E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGLX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjGLX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0691724;
        Wed, 12 Jul 2023 16:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA01619A0;
        Wed, 12 Jul 2023 23:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3BD1C433C8;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689204481;
        bh=OkLQfd1Guhg9/SwPrwWjGykOzhKJA7Sqn9Gr9KDsb4E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QmDatwRYs6YrWE51oIm6H4qHI7Le1d7VqWS/leU8l3S2IyrBWMbhtI56XMZxVbi6r
         cwkBlWVjD5gDrAUImsT+oKjYJMS54IVi7N0aP5517rjqxlffaHczIrVAW4aDFA5Cgh
         ih0OacS0ya/bFK513MJ3L6qnSorBni2He6sEd0wdicv+11A4SqZ7boAGwSyktPELJ5
         abFDAvlch+MPIy1PGImVkUGfv7U9EmZCCtp32XWwchyyp7CRLZPKRAZrC9fmuU10Rn
         eNw1QuNvQWU5QqVn6oJ5Y8/X7RWRPy90eWUM20tHsj9GBCMnHlrRSv+RaFa2oZkndz
         TH3lGmQ2r/Ktw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8B9DC4167B;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.5-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d56a3a15-58f7-1af6-0563-55e2db4ac45b@redhat.com>
References: <d56a3a15-58f7-1af6-0563-55e2db4ac45b@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d56a3a15-58f7-1af6-0563-55e2db4ac45b@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-2
X-PR-Tracked-Commit-Id: 6b293a8c91bca52726448d03216e65da509e9bb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb26cbb1a754ccde5d4d74527dad5ba051808fad
Message-Id: <168920448175.20936.2005607830922077641.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jul 2023 23:28:01 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jul 2023 12:20:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb26cbb1a754ccde5d4d74527dad5ba051808fad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
