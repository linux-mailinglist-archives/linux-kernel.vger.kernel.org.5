Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839397DEAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbjKBCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbjKBCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:52:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442B18B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B37C433C9;
        Thu,  2 Nov 2023 02:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698893492;
        bh=rZ4OuooRolOsB44aW9nZuPPoINVmvXpmNNL08taFfm8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k1hPjoL8kQkQu+tyiqj0yUkL+Qw+vmpHHJgeda90Qj2IlB2aQsgrd8Atc/vCZarkP
         btJ4q4Um+qJXycH2vPZlvpEqmGaOX7kp0qQT6eC823bfFIY7N7LqbfSRMMev6y18QD
         kXUgF3sDqW2eyTx9TuqMjdRRXNkM1pCOTLgwP0FA6eqzSbuqViqE704ypIQRWeL6c0
         bajK2wHWymSI6QjqDxHIduxWdUJpF8FFVWHkG/hg7XIfyLIq4cnHoOX8oMSp8Jr2Gb
         9t4BKZ9Zy3mXarFaV3xNIYHevHMj7dhmaf0n+X9qf9whtNVdmMWt9zKslkJRHaRU/g
         Lpfu1nEqJW2TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66F02C395F3;
        Thu,  2 Nov 2023 02:51:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031131417.GA1815719@nvidia.com>
References: <20231031131417.GA1815719@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031131417.GA1815719@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: b2b67c997bf74453f3469d8b54e4859f190943bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 463f46e114f74465cf8d01b124e7b74ad1ce2afd
Message-Id: <169889349241.17707.8262732702876780148.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 02:51:32 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 10:14:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/463f46e114f74465cf8d01b124e7b74ad1ce2afd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
