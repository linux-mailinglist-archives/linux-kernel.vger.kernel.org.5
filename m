Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8A7DED32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjKBHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbjKBHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:23:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659E12B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:23:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9162CC433C7;
        Thu,  2 Nov 2023 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698909797;
        bh=TGEyMuVSbjIh/jEbfoCyC2DUpT+BmvyOKrikyBOWfw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lSnQYQiFI6vQUes5Mch00GcxxB3qRRP4tIWo8n7MJeG7uFEvPMV0FSLeFjwx+OfpN
         W5Z8rvN1r/fPGiF4KurjomGscSz6/5RY8EIuAEqrFAJsKrQpDfU/1sMPJqcFWOqLyA
         RCGAY3aDrIYU1dBxFVKzUOw+6zjyZfX3FUZCFTAcxPralL83FH6nYRkQY+5eK314UB
         iNgYU3McJ5imlgB2kGQl3nfLZR8Q1IhqHLx9etuCwy3hUA1B6uwwT0bVH5nW3XNe6d
         1QNtpU9YMqZgPo4jJ6ZNqP4CL49WQVAs9Q8KILMQSn+p1KF7t45y+/UtpZ2jaGkCHr
         rSIgVSG+AVz+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D570C43168;
        Thu,  2 Nov 2023 07:23:17 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.7-rc1
X-PR-Tracked-Commit-Id: ea0b0bcef4917a2640ecc100c768b8e785784834
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
Message-Id: <169890979750.20895.63719470937187142.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 07:23:17 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com,
        keescook@chromium.org, zhumao001@208suo.com,
        yangtiezhu@loongson.cn, ojeda@kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 13:13:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
