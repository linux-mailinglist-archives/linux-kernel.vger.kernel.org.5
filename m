Return-Path: <linux-kernel+bounces-136142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C489D06F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED49AB236C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9154661;
	Tue,  9 Apr 2024 02:37:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980B53E3B;
	Tue,  9 Apr 2024 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630279; cv=none; b=cHXLrfSibSoQNN/y6RFQJJI7co2n5Ix5Vo9aPUi1D5KHUin34o4HIQpt4tVL64+ma9oChoQkiuFqSmWqCPuJh7rUzBc3PmPj5MkB5cTCeUWnbxrkCK6NlPRiszgf5zZ8jfpyDjBCkVtGvDUf6sC6h6mEOMhPaiKdqGDcdinxeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630279; c=relaxed/simple;
	bh=pwOwA49kqxRLgLtkCTgbhZk912xpkTeIB7ap3rEEFHM=;
	h=From:Subject:Date:Message-ID:To; b=nKwvMErv0tHtu64o2ZnK/W1s7ixs6fy/Lpeie14A+4wnCNbCAtugWKCRbIFDAyLZctEXiSpjheF3/1rO96yh13hsZTgyYG0NTDbL66/+lromQhOFRuoRPGkoOlgGbNAqyVl3fdqVR8PjqxSwW/lU68KKl6d2HLq2HcZDRF8i20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D4BC433F1;
	Tue,  9 Apr 2024 02:37:58 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.25-rt29
Date: Tue, 09 Apr 2024 02:36:07 -0000
Message-ID: <171263016702.303145.16851042588391780903@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.25-rt29 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: cc516a9f9e4e7337fd49770c8df452146fd40a65

Or to build 6.6.25-rt29 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.25.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.25-rt29.patch.xz


Enjoy!
Clark

