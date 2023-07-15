Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8D7549F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGOP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828162729
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C3960BC0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 640A9C433C8;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689436654;
        bh=2nRuk+6Pp3A0/C5O5Cfzrkvv7MVujScCzLYMEO46QdM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DqGiRZm4Nypu0/+2UtEW4LTeydGFLIplM/bRBY4oojs3KdQVYxE0s8fuxfQWdrBc+
         7ftFtDcrE4f4HOTL4rKfUv04nn9oQ2ZM/geOmCtFNkpp1Uko7o41LvQD2aALvkkrGS
         Dwj73Yx89vxKKKCmTVE0iWk2wKGJdA09x9YRkhBfW+YQghAEHVKCWBgPoUfvvyIqxf
         phG6S5SDzyarQw6U/FXIY+Ry3GMM7DsAl0zhNddhlWfSWlLuJPXomtmVCjvKV+5YaN
         7o8DEqQJcJe71WpKjw5wVPb2qgtLvNOEl/vB7gDw7o1HQ6KhR11dSoOdzgCJ9uBS3E
         wi+q6jQLzE1Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 470A3C4167B;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZLGwoGoJNAG6Db4v@8bytes.org>
References: <ZLGwoGoJNAG6Db4v@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZLGwoGoJNAG6Db4v@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v6.5-rc1
X-PR-Tracked-Commit-Id: c20ecf7bb6153149b81a9277eda23398957656f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82678ab2a4af2b827d2b44b35b1295de8a1d312d
Message-Id: <168943665424.17130.1585047902367515642.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 15:57:34 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 22:31:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82678ab2a4af2b827d2b44b35b1295de8a1d312d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
