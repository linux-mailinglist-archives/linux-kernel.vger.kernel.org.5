Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F827E10C4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjKDTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKDTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9A1B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A97EC433C9;
        Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699126756;
        bh=BOZpFArWW1T5xfM9DHadV/pgH4GJEb9Dty1PKf4xMKc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HX2fZuzCP1rovxZm6Tt3xYcp4AlYFZygvPgq2RbMhcfecSHqgUBNXEU0teX+5R+Me
         ZSDX4tw5dG1530GTGWKFak264IHPw6MOY4ofFA3M9LaKbx+zvc9ZQaDg0rNLofGP+o
         HNwyUIriTgBDmBUp1ZrBxxtxRIiGeojDQbjQWfw237Dyel6eho7RitmvKBlcQUzxp2
         OlCVUnF4o/DyAhs9paI+DEEULHV/7MXxXCqz8yVQftpWB66EPHd2twcZZB1yuhT0hL
         IgX7VZ5BQBjQo2cIXlurf0Fe95DMHQaTGT5xNz/DddOmcCyEtIdIRBe0UyfQRNhFQ2
         EuSZGYdX1tjWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8A8C4316B;
        Sat,  4 Nov 2023 19:39:16 +0000 (UTC)
Subject: Re: [GIT PULL] 9p fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUW82S8bGg2BAeNU@codewreck.org>
References: <ZUW82S8bGg2BAeNU@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUW82S8bGg2BAeNU@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-6.7-rc1
X-PR-Tracked-Commit-Id: ce07087964208eee2ca2f9ee4a98f8b5d9027fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9b93cafb69cbbbe375de29c1ebf410dbc33ebfc
Message-Id: <169912675623.21555.5765396165383990631.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:39:16 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Nov 2023 12:39:05 +0900:

> https://github.com/martinetd/linux tags/9p-for-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9b93cafb69cbbbe375de29c1ebf410dbc33ebfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
