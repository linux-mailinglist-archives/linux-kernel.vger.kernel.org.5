Return-Path: <linux-kernel+bounces-2748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BB81614C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56902823B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D046B8C;
	Sun, 17 Dec 2023 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEaWHIs/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFE4653C;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C14B9C433C7;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834690;
	bh=C9SpFSsSi7c7QA6GG9nxXLyOXtppit1Joiry1xgyuuE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nEaWHIs/1k0ixhkn6tEX9kpOXkWEUuhct6hdZOd4XEA28rJwYcCIYo25fZ5U2z4d3
	 z6rVvJ5XJOG8Td1+kIB8DgxLG2qo3S3ZevdyBVxGzalhvA4vhucm1D/ofh3mTKiOrX
	 NeUWVSTYHgeuJi2ss90v9qkOFsYgxVFMhS5Obuf+2dM7LDnALaO6tQqoiAGyTyKj4b
	 UlfCB0gfV0sA0lyLPiF0OasPTOJXrxNXieuhSh75bvh3MNfxi9Q1s4Nl6HOXSeWtEj
	 A4WDvdeb/+/xhI3s09S9IQgFCt7bbGnLTfRwWWEiofJTQn2xeYaNne/iYMFYklS7eP
	 JSGK5JjfF9m8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1F7BC04DD9;
	Sun, 17 Dec 2023 17:38:10 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <657eabe7624f7_715492941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <657eabe7624f7_715492941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <657eabe7624f7_715492941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.7-rc6
X-PR-Tracked-Commit-Id: ef3d5cf9c59cccb012aa6b93d99f4c6eb5d6648e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 134fdb80bc130dba429295ac64358b16b695628c
Message-Id: <170283469072.25242.8405279832525626474.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:10 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 00:05:59 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/134fdb80bc130dba429295ac64358b16b695628c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

