Return-Path: <linux-kernel+bounces-58588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2731584E892
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33D72874E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809828E0B;
	Thu,  8 Feb 2024 18:52:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043362556D;
	Thu,  8 Feb 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418341; cv=none; b=hXPcBPKR0ic+AeatnBbgsgPOtTR4lP3wgri/7Bj/V8Jn3t5ldxt86WDki2Njz3O39+Swky0uRR2wiJOZDagfnrgvTH9QPYUZsdE0tqdcADapGgOAWcXD/1MKEnVFr3Jh/lrN+OOi4p92zMdga39bPHWsvvmrSvExO+fUDkelywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418341; c=relaxed/simple;
	bh=14BC7iqWDsiG7K2Hv0qoEKsomm795wf7EKhtlc4ZScY=;
	h=From:Subject:Date:Message-ID:To; b=ZkTp9Wk/j2hQkhanRfq25ts6XG78kiamT2WgRBn5NyVWxrcnV9Z9s2w0sg89Y4FfxtctIFlnFMyuhdv+llOl5lKtDNmiRymS0cyiZwR6OjM6gwF200u40mwDp8kywcq1uTCL8xldOl9VbzPTfxIiCeB5VSH2P20+6AGJ6sAYeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59894C43390;
	Thu,  8 Feb 2024 18:52:20 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.77-rt24
Date: Thu, 08 Feb 2024 18:50:35 -0000
Message-ID: <170741823540.2603154.417190173299275371@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.77-rt24 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 60d6e4c186efb23407715b7909208eddf248fa9d

Or to build 6.1.77-rt24 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.77.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.77-rt24.patch.xz


Enjoy!
Clark


