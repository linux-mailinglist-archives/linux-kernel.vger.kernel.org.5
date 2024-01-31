Return-Path: <linux-kernel+bounces-47217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F316844A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C268BB29518
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691E39AFA;
	Wed, 31 Jan 2024 21:58:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615339FE2;
	Wed, 31 Jan 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738320; cv=none; b=ArrN6z73P0qlf1EbTlsRjcp3W0kAUIfuo31YFd4Tfw3Dn+ijDB63EeVXLKuCbr7jlL5ADUfSjI05OSvh9PcHWamblAdaG1KckFOTcsrI+VZ2OQg0HeEft296Jdn1y6qESsD4ptIjEI1EBigmmAG2eAbNXcOGEHlHnvRUmfsMmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738320; c=relaxed/simple;
	bh=XQo8cgj8GwW2/wffULmfs92RdH9ijjEGTusk6tvS6g4=;
	h=From:Subject:Date:Message-ID:To; b=CWDM3wfP2XEkTvTpJAVTy+o9PTi7HAW/3cXryBOWe6LpeeKBiE0DevXtrqKxpNYoUXfTqAMGcCC+6sRK6ikbcv0oxz8hGBHzwQgGZEjyMYhBn4S0UnkZuRw1oXJLvBLQ5RiApVuSSoOciKJKvYPVPfqn6eEPQkWOrfrlWR/Ml9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C46C433C7;
	Wed, 31 Jan 2024 21:58:39 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.14-rt21
Date: Wed, 31 Jan 2024 21:54:30 -0000
Message-ID: <170673807068.1379990.16686498585763826009@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.14-rt21 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 696a477de80aff6e5ae22f885fc6a354720270de

Or to build 6.6.14-rt21 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.14.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.14-rt21.patch.xz


Enjoy!
Clark


