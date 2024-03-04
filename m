Return-Path: <linux-kernel+bounces-89987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F786F8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F223B20AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8932443D;
	Mon,  4 Mar 2024 02:48:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8F15B7;
	Mon,  4 Mar 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520492; cv=none; b=madTLe9UYz1nzK8eCimUwE5uCZQ+gyNEnKUy7s0VA0XiUasViw0ONtk3nxgLGpzHm55IDVxKk2yecguQO0cgEVWtM/WZ9cbQLy6HlAEBefpbuAxsn2f2EMbTMvlSLNOsJPRHszECflebA7L5fsoWliFZeJCnBbzTrSGO+jDLTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520492; c=relaxed/simple;
	bh=yHKLMpFa9IjeXN6PrDwhdENT33ebE6hZk0WttvahAvM=;
	h=From:Subject:Date:Message-ID:To; b=atZtpSghwCW6K5UfN37sPOnmaNZKzkZKdhdd/rCjPyFdrfrzyJDGC2xVDHCNzLeaDthJxdnjmx7QMKhg2lISntpN8R1wka3XlGrwWEjZALIwpxVU5OR6r3r7Ry1dfqxSYLnJWl7lKqYjR9mZ12lz+p4E2Yqerxq0ZOrAh3wCc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE232C433C7;
	Mon,  4 Mar 2024 02:48:11 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.20-rt25
Date: Mon, 04 Mar 2024 02:47:00 -0000
Message-ID: <170952042031.990094.14742139831553140389@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.20-rt25 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: a27814b8cd8f89ad68e29d3d6f8f3b61c65aebf5

Or to build 6.6.20-rt25 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.20.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.20-rt25.patch.xz


Enjoy!
Clark

