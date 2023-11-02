Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214367DED2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjKBHXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjKBHXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:23:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB5138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:23:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2E13C433C7;
        Thu,  2 Nov 2023 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698909794;
        bh=SWiJ8HDCVOzU/RmdaeaMb1iWYoXl2ujIZkdLEkmxp6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gaogNLAarjtkSvxD1Psv+xFk8gAmn1sIJesP8UfAbKdBctb8pnS9zG2qoz+3Cg6ml
         0RvwMb1B0V7PRYzZpUxg5/DKxcGTiK21SgbGCPa2SJ5YefMjIaSakmB7FItf28nZxh
         Waudxt6/hpX2jyHaXgJAyRdvlJT4qIsiHsPdnxjnGeJ2R4bTo6WeXKJvwqPqHTTYTL
         g0hL4ByvKxAeX4ehiHivGph+3LUaDExj5dpn15piZtrsu+Q0hCJbiw7wYBmYFu83rd
         CTdCbUTuP0JSvxs7TepkREFpF6X/w0MVrO0vbmTwZzdIAo/V3bD/S7jX0CsUBmjalO
         QRaSkTX1k9WYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FB6AC43168;
        Thu,  2 Nov 2023 07:23:14 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
References: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUKttkQ2/hgweOQP@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.7-rc1
X-PR-Tracked-Commit-Id: 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 426ee5196d1821d70192923e70c0f8347faade47
Message-Id: <169890979456.20895.8527754234743304909.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 07:23:14 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Granados <joel.granados@gmail.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 12:57:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/426ee5196d1821d70192923e70c0f8347faade47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
