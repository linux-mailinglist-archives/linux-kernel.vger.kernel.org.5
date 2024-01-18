Return-Path: <linux-kernel+bounces-30566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFD8320AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C18289D24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052082EAE6;
	Thu, 18 Jan 2024 21:00:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9F2E836;
	Thu, 18 Jan 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611623; cv=none; b=K+UTZRlTBuMFtrjYk10EByfDSto91z8O8Xr7h+gwyhlcVewYoR1uk66NkwDNp4mdEKCQ6anU7RB6R+c5slam0CuOG1fAu1qnvNMElcNKcH5qhiyRIgxVwVqk3Zl0oXZoY2e7gy/f9bR+V4OmxOW51pZ8vAeK3Ya+gpQHtXZhS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611623; c=relaxed/simple;
	bh=RGZ/6yYXJc2dzesWQsShgYezEPmebaXioIwxXhGT8dA=;
	h=From:Subject:Date:Message-ID:To; b=s+/qEQE+V0NLNL3GA1EnC5Coivejk1K6Vk07WPUT/XG1cQuMox/DFC5Zg0FQT5UJGjnCujKH0LqIPR2RRXPlCRfo/wE1IbeC+kmCemsbiQrmKTtDymXy7xgTyunVfm1WdzONs7RLQ9bnmWaN8FQDY6mmhHQxPeNCwalCs+gMyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE0EC433C7;
	Thu, 18 Jan 2024 21:00:22 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.12-rt20
Date: Thu, 18 Jan 2024 20:59:45 -0000
Message-ID: <170561158585.591793.15929255265114320850@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.12-rt20 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: cb00e5b8a8dfcf05048010551082c960b0eef099

Or to build 6.6.12-rt20 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.12.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.12-rt20.patch.xz


Enjoy!
Clark

