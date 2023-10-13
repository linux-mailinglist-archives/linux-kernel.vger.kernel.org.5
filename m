Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7577C8BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjJMQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJMQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5673BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F5C4C433D9;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215196;
        bh=Sv6lsoYwtFe0Y+SPz02c6oHW/S3tjRNc+gCICBeMoAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=baXEoQK3Ro78LA1IYq3JIVkMfGh1HS1d/nodq6QWaTbQEmlIrfSqUk0If2wbBxWxJ
         Q0gQVbAEznbD6jiXTusbtcEoUZWbnoXeQtUAyCABeJVcXi48IKa3qasusri2yA8uq8
         T3OXSAMUrJbaIeWUXAhfF5QRVkpmz9CpttLfW+THvF5YmVQnzd3Oz00odqrUTqOm2B
         rJ4WGApqAZbVl3LsVpSAuI5dNTFT3URvS6k2S9KqCXzzc5MMt4zS+Xjiib+O87YVqh
         CMcXuWFM3+JtMMjUs5dnSpPYFWFEZfMYmj5Q6ddCpGo9DMGGk++BQgYFdkR+GlGUiT
         8hP1wZp0a2yBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C597C691EF;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-429a0f54-5269-417c-af90-7edef235cd7d@palmer-ri-x1c9>
References: <mhng-429a0f54-5269-417c-af90-7edef235cd7d@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-429a0f54-5269-417c-af90-7edef235cd7d@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc6
X-PR-Tracked-Commit-Id: 3fec323339a4a9801a54e8b282eb571965b67b23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b82fbd8f39e2d3f2f6860f80bb888c5dbc3ce607
Message-Id: <169721519636.5219.12460477859107804908.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:56 +0000
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

The pull request you sent on Fri, 13 Oct 2023 07:12:59 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b82fbd8f39e2d3f2f6860f80bb888c5dbc3ce607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
