Return-Path: <linux-kernel+bounces-18180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010388259C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B5C281FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E134CEC;
	Fri,  5 Jan 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLp9yzjT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022D358AD;
	Fri,  5 Jan 2024 18:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 263EAC433C8;
	Fri,  5 Jan 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704478229;
	bh=0p6QTSUgNzsy9asxqQk+44xwJruAdICSzwzpvoLiajU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fLp9yzjTqfVghbhL0XHqYq7jtiEH/lsZ3gjAcLgE2B7N9HGSIaZa7R45PYSeApc5d
	 TYBh1gjUUbCHBEqbrh0cd9B42NhhQSwqk9DMmk/pgkv6YdJ9bq0Jg3Y4t83tcA3Bh5
	 1YWZUuAhGgjccL+/z3GEr0Y1TZmv+HY5kMBQj/gFXXWrukS4TedIhI+pHQHdQ6e8Re
	 us67HIy09q92LMbv+F3X97qVgj2WYnj+rarYFnf5IEiex5CwPsg2lDghzwgwWC900H
	 UlTp3rZS4BxdP9+v8N9fytHvNTOdQKMl9UA0ZZTz41TSgqzc42cd/EwKVqYMDuL6oC
	 62iCNSSh3oNug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14362DCB6D8;
	Fri,  5 Jan 2024 18:10:29 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client multichannel fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msj3W0t7QqkZuTgP9vW+gF=P2Y53ELGaiQe_Xi-pyTHfA@mail.gmail.com>
References: <CAH2r5msj3W0t7QqkZuTgP9vW+gF=P2Y53ELGaiQe_Xi-pyTHfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msj3W0t7QqkZuTgP9vW+gF=P2Y53ELGaiQe_Xi-pyTHfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc8-smb3-mchan-fixes
X-PR-Tracked-Commit-Id: 09eeb0723f219fbd96d8865bf9b935e03ee2ec22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eca89454aec4278c0debc918b4978a3f4a0581e
Message-Id: <170447822907.11319.13715010278654155092.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jan 2024 18:10:29 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Jan 2024 23:46:36 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc8-smb3-mchan-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eca89454aec4278c0debc918b4978a3f4a0581e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

