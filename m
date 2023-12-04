Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C3804139
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjLDV7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjLDV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A6CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:59:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81235C433C7;
        Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701727142;
        bh=mG8wdYHgXcY62vLiVOvKhsnH6FtRt36cVg8GDLHLCA4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u5RjSasIwqJItsP3bJhxJTXbT/tYtv/19VAIwjPdiPxzAYpGzWPubjmImEjK0/ZVA
         JzqramSgvZODUSz6kBREpgrJqvO7l7JeRzNz1IHzTH+c5INOBBcdL9tiYHyH1Ye+ee
         lmHbZhcG4qsVsVWgBGGz/yZ6trefSDIxmHgWGiME3w3tDm8zpwepxoIGFdvB9WQki/
         VFtwWfi5LaYvrtiN94c2PjX2cLzhoymCVuLQsvvcJkUsACzTixkOW25rDa6uxfIGFc
         c41kO4r7bIFWFCX4oeRtb5qTrg9AYpRFly92Cu4xh5SDAG9G6fqQgXlIlzDMfEnpBp
         mdxS7PRsAT0oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B500DD4EEF;
        Mon,  4 Dec 2023 21:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231204193534.GA2755851@nvidia.com>
References: <20231204193534.GA2755851@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231204193534.GA2755851@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 6f9c4d8c468c189d6dc470324bd52955f8aa0a10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
Message-Id: <170172714243.21763.11586425434188265851.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Dec 2023 21:59:02 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Dec 2023 15:35:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bee0e7762ad2c6025b9f5245c040fcc36ef2bde8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
