Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA87FC452
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjK1TgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjK1TgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:36:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24F1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:36:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56BF6C433C7;
        Tue, 28 Nov 2023 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701200175;
        bh=InSCNZvq57DpSpQsC8EpOot3F7N3rHCmHPI+zIqMzZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KSMoblQoilT9SJnnUGhCNMADNna576RiaN/YrQzVHDV/c3KXeNfXZ5PdQxm0l4uCe
         CVpg0ZFPoxoJHGzamLGmsTc8rdGDfgGZzEEHodsDyukv+Q/GrywAyBx+C3bw+pbns5
         nZofil32Zbd5D5FxQH8qNz/e/oJrJwU13qp2vHE72gduZMahchk6F4qKtHqLfIVakp
         GAyAp6YOeS/fMIjDQAGjyRemHBHYluVykSpWGgeAarfJN7ZLSxV4jJ6uQGv2hqqCjr
         QNAjMA5KeRxBGcOHPF9ZiIOcTDrYEJ4XhP0dJQ4sbJjBlbIo7UkV9g3t8z+xST+Awq
         STcUqiCogRPIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4454DDFAA84;
        Tue, 28 Nov 2023 19:36:15 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1701191460.git.dsterba@suse.com>
References: <cover.1701191460.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1701191460.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc3-tag
X-PR-Tracked-Commit-Id: 0ac1d13a55eb37d398b63e6ff6db4a09a2c9128c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18d46e76d7c2eedd8577fae67e3f1d4db25018b0
Message-Id: <170120017526.16687.16192930897558695122.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Nov 2023 19:36:15 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Nov 2023 18:32:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18d46e76d7c2eedd8577fae67e3f1d4db25018b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
