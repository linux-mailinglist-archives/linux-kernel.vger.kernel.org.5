Return-Path: <linux-kernel+bounces-20237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A139827C42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BC8285509
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B84776F;
	Tue,  9 Jan 2024 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4IpGhZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FE79D4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6EB6C433B1;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704761258;
	bh=hjbk0jpjHWzxHWe43YarYuPERuyYyEUWkacCuQwB+4c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G4IpGhZHOBj4YQnttveICJhlA199HJsZwP1RvL9qaR2BNwIweev9yj2DHL+27ZoNf
	 JCGQq5B4HgID5GhG3w3MzIhbF3EkZU1d53h67NixQTk5BpsNRzJNiJKJyXXl67IZl1
	 T6QJtLq6Py0ZqtvC0Yvl6R20h6kCtBDGvIRxrarGBtk/o+h4RzaWCE5yFNVwHQ+bEa
	 FdO1U3PCyHkEordy24wtUhCyWGAcv60H7ByFnT5dh2hqnF5bBwHUvRTLIMjzu3Ugbc
	 vrgpQsb+Zw7dulLu2CQG/FKyFjCEgOsWIBUjCDV93haEr+J2vUHPsRHKQgrJ9twRz8
	 Pq81BMvUOXhOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5855DFC686;
	Tue,  9 Jan 2024 00:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108112606.3014783-1-geert@linux-m68k.org>
References: <20240108112606.3014783-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108112606.3014783-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.8-tag1
X-PR-Tracked-Commit-Id: 6b9c045b0602cf64b33ea6da5e6aa6f81dd47ae8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cf1d6a5fbf3f724d12b01635319924239d42c00
Message-Id: <170476125873.27312.9903393388133793450.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 00:47:38 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Jan 2024 12:26:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.8-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cf1d6a5fbf3f724d12b01635319924239d42c00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

